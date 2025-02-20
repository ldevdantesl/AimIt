//
//  GoalRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import CoreData

enum GoalRepositoryError: Error {
    case goalNotFound
    
    var localizedDescription: String {
        switch self {
        case .goalNotFound:
            return "Goal with specific id is not found"
        }
    }
}

final class GoalRepositoryImpl: GoalRepository {
    
    private let CDStack: CoreDataStack
    private let notificationService: NotificationService
    
    init(CDStack: CoreDataStack, notificationService: NotificationService) {
        self.CDStack = CDStack
        self.notificationService = notificationService
    }
    
    // MARK: - FETCHING
    func fetchGoals() throws -> [Goal] {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "deadline", ascending: true)]
        let goalEntity = try CDStack.viewContext.fetch(request)
        return goalEntity.map(GoalMapper.mapToDomain)
    }
    
    func fetchGoalByID(id: UUID) throws -> Goal {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        let entity = try CDStack.viewContext.fetch(request)
        guard let goal = entity.first else { throw GoalRepositoryError.goalNotFound }
        return GoalMapper.mapToDomain(from: goal)
    }
    
    func fetchGoalsByPrompt(with prompt: String, in workspace: Workspace) throws -> [Goal] {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "title CONTAINS[c] %@ OR desc CONTAINS[c] %@", prompt, prompt),
            NSPredicate(format: "workspace.id == %@", workspace.id.uuidString),
            NSPredicate(format: "isCompleted == false")
        ])
        
        return try CDStack.viewContext.fetch(fetchRequest).map(GoalMapper.mapToDomain)
    }
    
    func fetchCompletedGoalsForWorkspace(_ workspace: Workspace) throws -> [Goal] {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "workspace.id == %@", workspace.id.uuidString),
            NSPredicate(format: "isCompleted == true")
        ])
        let goals = try CDStack.viewContext.fetch(request)
        return goals.map(GoalMapper.mapToDomain)
    }
    
    // MARK: - ADDING
    func addGoal(
        to workspace: Workspace,
        title: String,
        desc: String?,
        deadline: Date?,
        milestones: [Milestone]
    ) throws {
        let newGoal = GoalEntity(context: CDStack.viewContext)
        newGoal.id = UUID()
        newGoal.title = title
        newGoal.desc = desc
        newGoal.deadline = deadline.flatMap(DeadlineFormatter.formatToTheEndOfTheDay) ?? Date()
        newGoal.deadlineChanges = 0
        newGoal.createdAt = Date()
        newGoal.isCompleted = false
        newGoal.completedAt = nil
        
        let milestoneEntities = milestones.map { milestone -> MilestoneEntity in
            let milestoneEntity = MilestoneEntity(context: CDStack.viewContext)
            milestoneEntity.id = milestone.id
            milestoneEntity.desc = milestone.desc
            milestoneEntity.systemImage = milestone.systemImage
            milestoneEntity.isCompleted = milestone.isCompleted
            milestoneEntity.dueDate = milestone.dueDate.flatMap(DeadlineFormatter.formatToTheEndOfTheDay)
            milestoneEntity.createdAt = milestone.createdAt
            milestoneEntity.completedAt = nil
            milestoneEntity.goal = newGoal
            return milestoneEntity
        }
        
        newGoal.milestones = NSSet(array: milestoneEntities)
        do {
            try milestoneEntities.forEach(scheduleNotificationFor)
        } catch {
            print("Failed to schedule notification for milestone: \(error.localizedDescription)")
        }
        
        
        let workspaceEntity = WorkspaceMapper.toEntity(workspace, context: CDStack.viewContext)
        workspaceEntity.addToGoals(newGoal)
        newGoal.workspace = workspaceEntity
        
        do {
            try scheduleNotification(for: newGoal)
        } catch let error as NotificationErrors {
            print("Failed to schedule notification: \(error.errorDescription)")
        } catch {
            print("Failed to schedule notification: \(error.localizedDescription)")
        }
        
        saveContext()
    }
    
    // MARK: - EDITING
    func editGoal(
        _ goal: Goal,
        newTitle: String?,
        newDesc: String?,
        newDeadline: Date?,
        newMilestones: [Milestone]?
    ) throws -> Goal {
        let context = CDStack.viewContext
        let goalEntity = GoalMapper.toEntity(from: goal, context: context)
        
        goalEntity.title = newTitle ?? goalEntity.title
        goalEntity.desc = newDesc ?? goalEntity.desc
        
        if let newDeadline = newDeadline {
            goalEntity.deadline = DeadlineFormatter.formatToTheEndOfTheDay(newDeadline) ?? goalEntity.deadline
            goalEntity.deadlineChanges += 1
        }
        
        if let newMilestones {
            let existingMilestones = goalEntity.milestones as? Set<MilestoneEntity> ?? Set()
            let newMilestoneIDs = Set(newMilestones.map { $0.id })
            
            let milestonesToRemove = existingMilestones.filter { !newMilestoneIDs.contains($0.id) }
            
            milestonesToRemove.forEach(removeNotification)
            
            milestonesToRemove.forEach { milestoneEntity in
                goalEntity.removeFromMilestones(milestoneEntity)
                context.delete(milestoneEntity)
            }
            
            let updatedMilestones = newMilestones.map { milestone -> MilestoneEntity in
                if let existingEntity = existingMilestones.first(where: { $0.id == milestone.id }) {
                    existingEntity.desc = milestone.desc
                    existingEntity.systemImage = milestone.systemImage
                    existingEntity.isCompleted = milestone.isCompleted
                    existingEntity.dueDate = milestone.dueDate
                    existingEntity.createdAt = milestone.createdAt
                    existingEntity.goal = goalEntity
                    return existingEntity
                } else {
                    let newEntity = MilestoneEntity(context: context)
                    newEntity.id = milestone.id
                    newEntity.desc = milestone.desc
                    newEntity.systemImage = milestone.systemImage
                    newEntity.isCompleted = milestone.isCompleted
                    newEntity.createdAt = milestone.createdAt
                    newEntity.dueDate = milestone.dueDate.flatMap { DeadlineFormatter.formatToTheEndOfTheDay($0) }
                    newEntity.goal = goalEntity
                    return newEntity
                }
            }
            
            updatedMilestones.forEach(removeNotification)
            updatedMilestones.forEach {
                do {
                    try scheduleNotificationFor(milestone: $0)
                } catch {
                    print("Error scheduling notification for \($0.desc): \(error.localizedDescription)")
                }
            }
            
            goalEntity.milestones = NSSet(array: updatedMilestones)
        }
        
        saveContext()
        
        removeNotification(for: goalEntity)
        
        do {
            try scheduleNotification(for: goalEntity)
        } catch let error as NotificationErrors {
            print("Error scheduling notification: \(error.errorDescription)")
        } catch {
            print("Error scheduling notification: \(error.localizedDescription)")
        }
        
        return GoalMapper.mapToDomain(from: goalEntity)
    }
    
    // MARK: - DELETING
    func deleteGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDStack.viewContext)
        CDStack.viewContext.delete(goalEntity)
        removeNotification(for: goalEntity)
        saveContext()
    }
    
    // MARK: - COMPLETION
    func completeGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDStack.viewContext)
        goalEntity.isCompleted = true
        goalEntity.completedAt = DeadlineFormatter.formatToTheEndOfTheDay(Date())
    
        if let prioritizedGoal = goalEntity.workspace?.prioritizedGoal, prioritizedGoal.id == goalEntity.id {
            goalEntity.workspace?.prioritizedGoal = nil
        }

        removeNotification(for: goalEntity)

        saveContext()
    }
    
    func uncompleteGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDStack.viewContext)
        goalEntity.isCompleted = false
        goalEntity.completedAt = nil

        do {
            try scheduleNotification(for: goalEntity)
        } catch {
            print("Error scheduling notification: \(error.localizedDescription)")
        }

        saveContext()
    }
    
    // MARK: - Scheduling Notification
    private func scheduleNotification(for goal: GoalEntity) throws {
        guard UserDefaults.standard.bool(forKey: ConstantKeys.isNotificationsEnabled) else {
            throw NotificationErrors.notificationsAreDisabled
        }
        
        guard let dayBeforeDeadline = Calendar.current.date(byAdding: .day, value: -1, to: goal.deadline) else {
            throw NSError(domain: "Day Before deadline is nil", code: -230, userInfo: nil)
        }
        
        var components = Calendar.current.dateComponents([.year, .month, .day], from: dayBeforeDeadline)
            components.hour = 9
            components.minute = 0
            components.second = 0
        
        guard let notifyDate = Calendar.current.date(from: components) else {
            throw NSError(domain: "Notify date is nil", code: -230, userInfo: nil)
        }
        
        guard Date() < notifyDate else {
            throw NSError(domain: "Notify date is already passed.", code: -230, userInfo: nil)
        }
        
        Task {
            do {
                try await notificationService.scheduleNotification(
                    identifier: goal.id.uuidString,
                    title: "Goal Reminder in \(goal.workspace?.title ?? "") workspace",
                    body: "Your goal \"\(goal.title)\" is due tomorrow.",
                    date: notifyDate
                )
                
                print("Successfully scheduled notification for \(goal.title)")
            } catch {
                print("Failed to schedule notification: \(error.localizedDescription)")
                throw error
            }
        }
    }
    
    private func scheduleNotificationFor(milestone: MilestoneEntity) throws {
        guard UserDefaults.standard.bool(forKey: ConstantKeys.isNotificationsEnabled) else {
            throw NotificationErrors.notificationsAreDisabled
        }
        
        guard let dueDate = milestone.dueDate else {
            throw NSError(domain: "Milestone don't have a dueDate \(milestone.desc)", code: -10)
        }
        
        guard !milestone.isCompleted else {
            throw NSError(domain: "Milestone is completed already \(milestone.desc)", code: -1)
        }
        
        var components = Calendar.current.dateComponents([.year, .month, .day], from: dueDate)
            components.hour = 9
            components.minute = 0
            components.second = 0
        
        guard let notifyDate = Calendar.current.date(from: components) else {
            throw NSError(domain: "Notify date is nil", code: -230)
        }
        
        guard Date() < notifyDate else {
            throw NSError(domain: "Date is already passed nil", code: -230)
        }
    
        Task {
            do {
                try await notificationService.scheduleNotification(
                    identifier: milestone.id.uuidString,
                    title: "\(milestone.desc) is due today",
                    body: "Don't forget to complete milestone.",
                    date: notifyDate
                )
                print("Successfully scheduled notification for \(milestone.desc)")
                
            } catch let error as NotificationErrors {
                print("Failed to schedule notification: \(error.errorDescription)")
                throw error
            } catch {
                print("Failed to schedule notification: \(error.localizedDescription)")
                throw error
            }
        }
    }
    
    private func removeNotification(for goal: GoalEntity) {
        notificationService.cancelNotification(identifier: goal.id.uuidString)
        print("Successfully removed notification for \(goal.title)")
    }
    
    private func removeNotification(for milestone: MilestoneEntity) {
        notificationService.cancelNotification(identifier: milestone.id.uuidString)
        print("Successfully removed notification for \(milestone.desc)")
    }
    
    // MARK: - OTHER
    private func saveContext() {
        CDStack.saveContext()
    }
    
}
