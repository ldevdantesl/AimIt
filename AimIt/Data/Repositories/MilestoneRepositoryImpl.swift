//
//  MilestoneRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation
import CoreData

final class MilestoneRepositoryImpl: MilestoneRepository {
    private var CDstack: CoreDataStack
    
    init(CDstack: CoreDataStack) {
        self.CDstack = CDstack
    }
    
    // MARK: - FETCHING
    func fetchAllMilestones() throws -> [Milestone] {
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        return try CDstack.viewContext.fetch(fetchRequest).map(MilestoneMapper.toDomain)
    }

    func fetchMilestones(for goal: Goal) throws -> [Milestone] {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "goal == %@", goalEntity)
        return try CDstack.viewContext.fetch(fetchRequest).map(MilestoneMapper.toDomain)
    }

    func fetchMilestonesByPrompt(with prompt: String, in workspace: Workspace) throws -> [Milestone] {
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        
        let promptPredicate = NSPredicate(format: "desc CONTAINS[c] %@", prompt)
        
        let workspacePredicate = NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString)
        
        var prioritizedGoalPredicate: NSPredicate? = nil
        if let prioritizedGoalID = workspace.prioritizedGoal?.id {
            prioritizedGoalPredicate = NSPredicate(format: "goal.id == %@", prioritizedGoalID.uuidString)
        }
        
        var predicates: [NSPredicate] = [promptPredicate]
        if let prioritizedPredicate = prioritizedGoalPredicate {
            let workspaceOrPrioritizedPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [workspacePredicate, prioritizedPredicate])
            predicates.append(workspaceOrPrioritizedPredicate)
        } else {
            predicates.append(workspacePredicate)
        }
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        return try CDstack.viewContext.fetch(fetchRequest).map { MilestoneMapper.toDomain($0) }
    }
    
    func fetchTodayMilestonesForWorkspace(
        for workspace: Workspace,
        date: Date
    ) throws -> [Milestone] {
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)?.addingTimeInterval(-1) ?? Date()
    
        let workspacePredicate = NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString)
        
        var prioritizedGoalPredicate: NSPredicate? = nil
        if let prioritizedGoalID = workspace.prioritizedGoal?.id {
            prioritizedGoalPredicate = NSPredicate(format: "goal.id == %@", prioritizedGoalID.uuidString)
        }
        
        let completedPredicate = NSPredicate(format: "isCompleted == false")
        let datePredicate = NSPredicate(format: "dueDate >= %@ AND dueDate <= %@", startOfDay as NSDate, endOfDay as NSDate)
        
        var predicates: [NSPredicate] = [completedPredicate, datePredicate]
        if let prioritizedPredicate = prioritizedGoalPredicate {
            let combinedWorkspacePredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [workspacePredicate, prioritizedPredicate])
            predicates.append(combinedWorkspacePredicate)
        } else {
            predicates.append(workspacePredicate)
        }
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        return try CDstack.viewContext.fetch(fetchRequest).map(MilestoneMapper.toDomain)
    }
    
    // MARK: - ADDING
    func addMilestone(
        desc: String,
        systemImage: String,
        dueDate: Date?,
        completed: Bool,
        to goal: Goal
    ) throws {
        let newMilestone = MilestoneEntity(context: CDstack.viewContext)
        newMilestone.id = UUID()
        newMilestone.desc = desc
        newMilestone.isCompleted = completed
        newMilestone.systemImage = systemImage
        newMilestone.createdDate = Date()
        newMilestone.completedDate = nil
        newMilestone.dueDate = dueDate.flatMap { DeadlineFormatter.formatToTheEndOfTheDay($0) }
        newMilestone.goal = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        
        saveContext()
    }
    
    // MARK: - EDITING
    func updateMilestone(
        _ milestone: Milestone,
        desc: String?,
        systemImage: String?,
        dueDate: Date?
    ) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: CDstack.viewContext)
        milestoneEntity.desc = desc ?? milestoneEntity.desc
        milestoneEntity.dueDate = dueDate.flatMap { DeadlineFormatter.formatToTheEndOfTheDay($0) } ?? milestoneEntity.dueDate
        milestoneEntity.systemImage = systemImage ?? milestoneEntity.systemImage
        
        saveContext()
    }
    
    // MARK: - DELETING
    func deleteMilestone(_ milestone: Milestone) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: CDstack.viewContext)
        CDstack.viewContext.delete(milestoneEntity)
        saveContext()
    }

    // MARK: - COMPLETION
    func toggleMilestoneCompletion(_ milestone: Milestone) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: CDstack.viewContext)
        milestoneEntity.isCompleted.toggle()
        milestoneEntity.completedDate = milestoneEntity.isCompleted ? DeadlineFormatter.formatToTheEndOfTheDay(Date()) : nil
        saveContext()
    }
    
    // MARK: - OTHER
    func createSeparateMilestone(
        desc: String,
        systemImage: String,
        dueDate: Date?,
        completed: Bool
    ) throws -> Milestone {
        return Milestone(
            id: UUID(),
            desc: desc,
            systemImage: systemImage,
            creationDate: .now,
            completionDate: nil,
            dueDate: dueDate.flatMap { DeadlineFormatter.formatToTheEndOfTheDay($0) },
            isCompleted: completed,
            goalID: nil
        )
    }
    
    private func saveContext() {
        CDstack.saveContext()
    }
}
