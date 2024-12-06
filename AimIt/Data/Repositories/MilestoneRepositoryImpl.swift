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
    
    func addMilestone(desc: String, to goal: Goal) throws {
        let newMilestone = MilestoneEntity(context: CDstack.viewContext)
        newMilestone.id = UUID()
        newMilestone.desc = desc
        newMilestone.isCompleted = false
        newMilestone.goal = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        
        try saveContext()
    }
    
    func updateMilestone(_ milestone: Milestone, desc: String) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: CDstack.viewContext)
        milestoneEntity.desc = desc
        
        try saveContext()
    }
    
    func deleteMilestone(_ milestone: Milestone) throws {
        let milestoneEntity = MilestoneMapper.toEntity(milestone, context: CDstack.viewContext)
        CDstack.viewContext.delete(milestoneEntity)
        try saveContext()
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
        milestoneEntity.isCompleted = milestoneEntity.isCompleted ? false : true
        try saveContext()
    }
    
    private func saveContext() throws {
        try CDstack.saveContext()
    }
}
