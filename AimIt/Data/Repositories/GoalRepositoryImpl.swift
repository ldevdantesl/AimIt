//
//  GoalRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import CoreData

final class GoalRepositoryImpl: GoalRepository {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }
    
    func addGoal(
        title: String,
        desc: String?,
        deadline: Date?
    ) throws {
        let newGoal = GoalEntity(context: context)
        newGoal.id = UUID()
        newGoal.title = title
        newGoal.desc = desc
        newGoal.deadline = deadline
        newGoal.createdAt = Date()
        newGoal.isCompleted = false
        newGoal.completedAt = nil
        
        try saveContext()
    }
    
    func editGoal(
        _ goal: Goal,
        newTitle: String?,
        newDesc: String?,
        newDeadline: Date?
    ) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: context)
        
        goalEntity.title = newTitle ?? goalEntity.title
        goalEntity.desc = newDesc ?? goalEntity.desc
        goalEntity.deadline = newDeadline ?? goalEntity.deadline
        
        try saveContext()
    }
    
    func completeGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: context)
        goalEntity.isCompleted = true
        goalEntity.completedAt = Date()
        try saveContext()
    }
    
    func uncompleteGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: context)
        goalEntity.isCompleted = false
        goalEntity.completedAt = nil
        try saveContext()
    }
    
    func deleteGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: context)
        if context == goalEntity.managedObjectContext {
            context.delete(goalEntity)
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
        let goalEntity = try context.fetch(request)
        let goalDomain = goalEntity.map { GoalMapper.mapToDomain(from: $0) }
        return goalDomain
    }
    
    private func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
