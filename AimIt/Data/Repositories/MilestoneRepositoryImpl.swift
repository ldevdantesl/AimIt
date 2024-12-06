//
//  MilestoneRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation
import CoreData

final class MilestoneRepositoryImpl: MilestoneRepository {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }
    
    func addMilestone(desc: String, to goal: Goal) throws {
        let newMilestone = MilestoneEntity(context: context)
        newMilestone.id = UUID()
        newMilestone.desc = desc
        newMilestone.isCompleted = false
        newMilestone.goal = GoalMapper.toEntity(from: goal, context: context)
        
        try saveContext()
    }
    
    func updateMilestone(_ milestone: Milestone, desc: String) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: context)
        milestoneEntity.desc = desc
        
        try saveContext()
    }
    
    func deleteMilestone(_ milestone: Milestone) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: context)
        context.delete(milestoneEntity)
        try saveContext()
    }
    
    func fetchMilestones(for goal: Goal) throws -> [Milestone] {
        let goalEntity = GoalMapper.toEntity(from: goal, context: context)
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "goal == %@", goalEntity)
        return try context.fetch(fetchRequest).map { MilestoneMapper.toDomain($0) }
    }
    
    func fetchAllMilestones() throws -> [Milestone] {
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        return try context.fetch(fetchRequest).map { MilestoneMapper.toDomain($0) }
    }
    
    func toggleMilestoneCompletion(_ milestone: Milestone) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: context)
        milestoneEntity.isCompleted = milestoneEntity.isCompleted ? false : true
        try saveContext()
    }
    
    private func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
