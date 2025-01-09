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
        newMilestone.dueDate = dueDate
        newMilestone.goal = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        
        saveContext()
    }
    
    func updateMilestone(
        _ milestone: Milestone,
        desc: String?,
        systemImage: String?,
        dueDate: Date?
    ) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: CDstack.viewContext)
        milestoneEntity.desc = desc ?? milestoneEntity.desc
        milestoneEntity.dueDate = dueDate ?? milestoneEntity.dueDate
        milestoneEntity.systemImage = systemImage ?? milestoneEntity.systemImage
        
        saveContext()
    }
    
    func deleteMilestone(_ milestone: Milestone) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: CDstack.viewContext)
        CDstack.viewContext.delete(milestoneEntity)
        saveContext()
    }
    
    func fetchMilestones(for goal: Goal) throws -> [Milestone] {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "goal == %@", goalEntity)
        return try CDstack.viewContext.fetch(fetchRequest).map { MilestoneMapper.toDomain($0) }
    }
    
    func fetchAllMilestones() throws -> [Milestone] {
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        return try CDstack.viewContext.fetch(fetchRequest).map { MilestoneMapper.toDomain($0) }
    }
    
    func toggleMilestoneCompletion(_ milestone: Milestone) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: CDstack.viewContext)
        milestoneEntity.isCompleted.toggle()
        saveContext()
    }
    
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
            dueDate: dueDate,
            isCompleted: completed,
            goalID: nil
        )
    }
    
    private func saveContext() {
        CDstack.saveContext()
    }
}
