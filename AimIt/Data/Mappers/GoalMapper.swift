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
            title: goal.title,
            desc: goal.desc,
            isCompleted: goal.isCompleted,
            deadline: goal.deadline,
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
            return newEntity
        }
    }
}
