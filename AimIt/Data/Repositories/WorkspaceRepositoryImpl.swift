//
//  WorkspaceRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation
import CoreData

final class WorkspaceRepositoryImpl: WorkspaceRepository {
    
    private let CDStack: CoreDataStack
    
    init(CDStack: CoreDataStack) {
        self.CDStack = CDStack
    }
    
    func fetchWorkspaces() throws -> [Workspace] {
        let request: NSFetchRequest<WorkspaceEntity> = WorkspaceEntity.fetchRequest()
        let entities = try CDStack.viewContext.fetch(request)
        return entities.map { WorkspaceMapper.toDomain($0) }
    }
    
    func fetchCurrentWorkspace(by id: UUID) throws -> Workspace {
        let request: NSFetchRequest<WorkspaceEntity> = WorkspaceEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        let workspaces = try CDStack.viewContext.fetch(request)
        guard let workspace = workspaces.first else {
            throw NSError(domain: "Workspace with this id is not found", code: -10)
        }
        
        return WorkspaceMapper.toDomain(workspace)
    }
    
    func addWorkspace(title: String) throws -> Workspace{
        let newWorkspace = WorkspaceEntity(context: CDStack.viewContext)
        newWorkspace.id = UUID()
        newWorkspace.title = title
        newWorkspace.goals = []
        
        CDStack.saveContext()
        
        return WorkspaceMapper.toDomain(newWorkspace)
    }
    
    func deleteWorkspace(_ workspace: Workspace) throws {
        let entity = WorkspaceMapper.toEntity(workspace, context: CDStack.viewContext)
        
        if CDStack.viewContext == entity.managedObjectContext {
            CDStack.viewContext.delete(entity)
            CDStack.saveContext()
        } else {
            throw NSError(
                domain: "CoreDataError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Object is not managed by the current context"]
            )
        }
    }
    
    func editWorkspace(workspace: Workspace, newTitle: String, newGoals: [Goal]) throws {
        let entity = WorkspaceMapper.toEntity(workspace, context: CDStack.viewContext)
        entity.title = newTitle
        entity.goals = NSSet(array: newGoals)
        CDStack.saveContext()
    }
}
