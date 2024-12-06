//
//  MilestoneMapper.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import CoreData

struct MilestoneMapper {
    static func toDomain(_ milestoneEntity: MilestoneEntity) -> Milestone {
        return Milestone(
            id: milestoneEntity.id,
            desc: milestoneEntity.desc,
            isCompleted: milestoneEntity.isCompleted,
            goalID: milestoneEntity.goal.id
        )
    }
    
    static func toEntity(_ milestone: Milestone, context: NSManagedObjectContext) -> MilestoneEntity {
        let fetchRequest: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", milestone.id as CVarArg)
        
        if let existingEntity = try? context.fetch(fetchRequest).first {
            return existingEntity
        } else {
            let entity = MilestoneEntity(context: context)
            entity.id = milestone.id
            entity.desc = milestone.desc
            entity.isCompleted = milestone.isCompleted
            
            let goalFetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
            goalFetchRequest.predicate = NSPredicate(format: "id == %@", milestone.goalID as CVarArg)
            
            guard let goalEntity = try? context.fetch(goalFetchRequest).first else {
                fatalError("Goal not found for the provided goalID")
            }
            
            entity.goal = goalEntity
            return entity
        }
    }
}
