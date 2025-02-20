//
//  GoalMapper.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import CoreData

struct GoalMapper {
    static func mapToDomain(from goal: GoalEntity) -> Goal {
        return Goal(
            id: goal.id,
            workspaceID: goal.workspace?.id ?? UUID(),
            title: goal.title,
            desc: goal.desc,
            isCompleted: goal.isCompleted,
            deadline: goal.deadline,
            deadlineChanges: Int(goal.deadlineChanges),
            createdAt: goal.createdAt,
            completedAt: goal.completedAt,
            milestones: (goal.milestones as? Set<MilestoneEntity>)?.map {
                MilestoneMapper.toDomain($0)
            }.sorted(by: {
                $0.isCompleted && !$1.isCompleted
            }) ?? []
        )
    }
    
    
    static func toEntity(from goal: Goal, context: NSManagedObjectContext) -> GoalEntity {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        if let existingEntity = try? context.fetch(fetchRequest).first {
            return existingEntity
        } else {
            let newEntity = GoalEntity(context: context)
            newEntity.id = goal.id
            newEntity.title = goal.title
            newEntity.desc = goal.desc
            newEntity.deadline = goal.deadline
            newEntity.deadlineChanges = Int16(goal.deadlineChanges)
            newEntity.completedAt = goal.completedAt
            newEntity.isCompleted = goal.isCompleted
            newEntity.createdAt = goal.createdAt
            newEntity.milestones = NSSet(array: goal.milestones)

            let request: NSFetchRequest<WorkspaceEntity> = WorkspaceEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", goal.workspaceID.uuidString)
            
            guard let workspaceEntity = try? context.fetch(request).first else {
                fatalError("Workspace is not found for the provided workspaceID")
            }
            
            newEntity.workspace = workspaceEntity
            newEntity.workspaceForPrioritizedGoal = workspaceEntity
            return newEntity
        }
    }
}
