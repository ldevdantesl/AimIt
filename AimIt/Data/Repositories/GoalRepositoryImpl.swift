//
//  GoalRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import CoreData

final class GoalRepositoryImpl: GoalRepository {
    
    private let CDstack: CoreDataStack
    
    init(CDstack: CoreDataStack) {
        self.CDstack = CDstack
    }
    
    func addGoal(
        title: String,
        desc: String?,
        deadline: Date?,
        milestones: [Milestone]
    ) throws {
        let newGoal = GoalEntity(context: CDstack.viewContext)
        newGoal.id = UUID()
        newGoal.title = title
        newGoal.desc = desc
        newGoal.deadline = deadline
        newGoal.createdAt = Date()
        newGoal.isCompleted = false
        newGoal.completedAt = nil
        
        let milestoneEntities = milestones.map { milestone -> MilestoneEntity in
            let milestoneEntity = MilestoneEntity(context: CDstack.viewContext)
            milestoneEntity.id = milestone.id
            milestoneEntity.desc = milestone.desc
            milestoneEntity.systemImage = milestone.systemImage
            milestoneEntity.isCompleted = milestone.isCompleted
            milestoneEntity.goal = newGoal
            return milestoneEntity
        }
        
        newGoal.milestones = NSSet(array: milestoneEntities)
        
        try saveContext()
    }
    
    func editGoal(
        _ goal: Goal,
        newTitle: String?,
        newDesc: String?,
        newDeadline: Date?
    ) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        
        goalEntity.title = newTitle ?? goalEntity.title
        goalEntity.desc = newDesc ?? goalEntity.desc
        goalEntity.deadline = newDeadline ?? goalEntity.deadline
        
        try saveContext()
    }
    
    func completeGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        goalEntity.isCompleted = true
        goalEntity.completedAt = Date()
        try saveContext()
    }
    
    func uncompleteGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        goalEntity.isCompleted = false
        goalEntity.completedAt = nil
        try saveContext()
    }
    
    func deleteGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        if CDstack.viewContext == goalEntity.managedObjectContext {
            CDstack.viewContext.delete(goalEntity)
            try saveContext()
        } else {
            throw NSError(
                domain: "CoreDataError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Object is not managed by the current context"]
            )
        }
    }
    
    func fetchGoals() throws -> [Goal] {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        let goalEntity = try CDstack.viewContext.fetch(request)
        let goalDomain = goalEntity.map { GoalMapper.mapToDomain(from: $0) }
        return goalDomain
    }
    
    private func saveContext() throws {
        try CDstack.saveContext()
    }
}
