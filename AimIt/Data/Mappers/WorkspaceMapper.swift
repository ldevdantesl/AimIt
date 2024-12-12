//
//  WorkspaceMapper.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation
import CoreData

struct WorkspaceMapper {
    static func toDomain(_ workspace: WorkspaceEntity) -> Workspace {
        return Workspace(
            id: workspace.id,
            title: workspace.title,
            goals: (workspace.goals as? Set<GoalEntity>)?.map {
                GoalMapper.mapToDomain(from: $0)
            } ?? []
        )
    }
    
    static func toEntity(_ workspace: Workspace, context: NSManagedObjectContext) -> WorkspaceEntity {
        let fetchRequest: NSFetchRequest<WorkspaceEntity> = WorkspaceEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", workspace.id as CVarArg)
        
        if let existingEntity = try? context.fetch(fetchRequest).first {
            return existingEntity
        } else {
            let newEntity = WorkspaceEntity(context: context)
            newEntity.id = workspace.id
            newEntity.title = workspace.title
            newEntity.goals = NSSet(array: workspace.goals)
            return newEntity
        }
    }
}
