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
    
    private let CDstack: CoreDataStack
    
    init(CDstack: CoreDataStack) {
        self.CDstack = CDstack
    }
    
    // MARK: - FETCHING
    func fetchGoals() throws -> [Goal] {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        let goalEntity = try CDstack.viewContext.fetch(request)
        let goalDomain = goalEntity.map { GoalMapper.mapToDomain(from: $0) }
        return goalDomain
    }
    
    func fetchGoalByID(id: UUID) throws -> Goal {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        let entity = try CDstack.viewContext.fetch(request)
        guard let goal = entity.first else { throw GoalRepositoryError.goalNotFound }
        return GoalMapper.mapToDomain(from: goal)
    }
    
    // MARK: - ADDING
    func addGoal(
        to workspace: Workspace,
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
            milestoneEntity.dueDate = milestone.dueDate
            milestoneEntity.createdDate = milestone.creationDate
            milestoneEntity.goal = newGoal
            return milestoneEntity
        }
        
        newGoal.milestones = NSSet(array: milestoneEntities)
        
        let workspaceEntity = WorkspaceMapper.toEntity(workspace, context: CDstack.viewContext)
        workspaceEntity.addToGoals(newGoal)
        newGoal.workspace = workspaceEntity
        
        saveContext()
    }
    
    // MARK: - EDITING
    func editGoal(
        _ goal: Goal,
        newTitle: String?,
        newDesc: String?,
        newDeadline: Date?,
        newMilestones: [Milestone]
    ) throws -> Goal {
        let context = CDstack.viewContext
        let goalEntity = GoalMapper.toEntity(from: goal, context: context)
        
        goalEntity.title = newTitle ?? goalEntity.title
        goalEntity.desc = newDesc ?? goalEntity.desc
        goalEntity.deadline = newDeadline ?? goalEntity.deadline
        
        let existingMilestones = goalEntity.milestones as? Set<MilestoneEntity> ?? Set()
        let newMilestoneIDs = Set(newMilestones.map { $0.id })
        
        let milestonesToRemove = existingMilestones.filter { !newMilestoneIDs.contains($0.id) }
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
                return existingEntity
            } else {
                let newEntity = MilestoneEntity(context: context)
                newEntity.id = milestone.id
                newEntity.desc = milestone.desc
                newEntity.systemImage = milestone.systemImage
                newEntity.isCompleted = milestone.isCompleted
                newEntity.dueDate = milestone.dueDate
                newEntity.goal = goalEntity
                return newEntity
            }
        }
        
        goalEntity.milestones = NSSet(array: updatedMilestones)
        
        saveContext()
        return GoalMapper.mapToDomain(from: goalEntity)
    }
    
    // MARK: - DELETING
    func deleteGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        if CDstack.viewContext == goalEntity.managedObjectContext {
            CDstack.viewContext.delete(goalEntity)
            saveContext()
        } else {
            throw NSError(
                domain: "CoreDataError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Object is not managed by the current context"]
            )
        }
    }
    
    // MARK: - COMPLETION
    func completeGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        goalEntity.isCompleted = true
        goalEntity.completedAt = Date()
        saveContext()
    }
    
    func uncompleteGoal(_ goal: Goal) throws {
        let goalEntity = GoalMapper.toEntity(from: goal, context: CDstack.viewContext)
        goalEntity.isCompleted = false
        goalEntity.completedAt = nil
        saveContext()
    }
    
    // MARK: - OTHER
    private func saveContext() {
        CDstack.saveContext()
    }
}
