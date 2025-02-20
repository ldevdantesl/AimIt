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
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "goal.id == %@", goal.id.uuidString)
        return try CDstack.viewContext.fetch(fetchRequest).map(MilestoneMapper.toDomain)
    }

    func fetchMilestonesByPrompt(with prompt: String, in workspace: Workspace) throws -> [Milestone] {
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "desc CONTAINS[c] %@", prompt),
            NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString),
            NSPredicate(format: "isCompleted == false")
        ])
        
        return try CDstack.viewContext.fetch(fetchRequest).map(MilestoneMapper.toDomain)
    }
    
    func fetchCompletedMilestoneForWorkspace(_ workspace: Workspace) throws -> [Milestone] {
        let request: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString),
            NSPredicate(format: "isCompleted == true")
        ])
        
        let milestones = try CDstack.viewContext.fetch(request)
        return milestones.map(MilestoneMapper.toDomain)
    }
    
    func fetchTodayMilestonesForWorkspace(
        for workspace: Workspace,
        date: Date
    ) throws -> [Milestone] {
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)?.addingTimeInterval(-1) ?? Date()
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[
            NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString),
            NSPredicate(format: "isCompleted == false"),
            NSPredicate(format: "dueDate >= %@ AND dueDate <= %@", startOfDay as NSDate, endOfDay as NSDate)
        ])
        
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
        newMilestone.createdAt = Date()
        newMilestone.completedAt = nil
        newMilestone.dueDate = dueDate.flatMap(DeadlineFormatter.formatToTheEndOfTheDay)
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
        milestoneEntity.dueDate = dueDate.flatMap(DeadlineFormatter.formatToTheEndOfTheDay) ?? milestoneEntity.dueDate
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
        milestoneEntity.completedAt = milestoneEntity.isCompleted ? DeadlineFormatter.formatToTheEndOfTheDay(Date()) : nil
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
            createdAt: .now,
            completedAt: nil,
            dueDate: dueDate.flatMap(DeadlineFormatter.formatToTheEndOfTheDay),
            isCompleted: completed,
            goalID: nil
        )
    }
    
    private func saveContext() {
        CDstack.saveContext()
    }
}
