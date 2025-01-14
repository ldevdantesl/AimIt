//
//  WorkspaceRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation
import CoreData

enum WorkspaceRepositoryErrors: Error {
    case workspaceNotFound
    case workspaceGoalsNotFound
}

final class WorkspaceRepositoryImpl: WorkspaceRepository {
    
    private let CDStack: CoreDataStack
    
    init(CDStack: CoreDataStack) {
        self.CDStack = CDStack
    }
    
    // MARK: - FETCH
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
        
        let sortedGoals: [Goal]
        if let goalSet = workspace.goals as? Set<GoalEntity>, !goalSet.isEmpty {
            sortedGoals = goalSet
                .sorted { $0.deadline < $1.deadline }
                .map { GoalMapper.mapToDomain(from: $0) }
        } else {
            sortedGoals = []
        }
        
        var workspaceDomain = WorkspaceMapper.toDomain(workspace)
        workspaceDomain.goals = sortedGoals
        
        return workspaceDomain
    }
    
    // MARK: - ADD
    func addWorkspace(title: String) throws -> Workspace{
        let newWorkspace = WorkspaceEntity(context: CDStack.viewContext)
        newWorkspace.id = UUID()
        newWorkspace.title = title
        newWorkspace.goals = []
        
        CDStack.saveContext()
        
        return WorkspaceMapper.toDomain(newWorkspace)
    }
    
    // MARK: - DELETE
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
    
    // MARK: - EDIT
    func editWorkspace(workspace: Workspace, newTitle: String, newGoals: [Goal]) throws {
        let entity = WorkspaceMapper.toEntity(workspace, context: CDStack.viewContext)
        entity.title = newTitle
        entity.goals = NSSet(array: newGoals)
        CDStack.saveContext()
    }
    
    // MARK: - PRIORITIZE
    func prioritizeGoal(in workspace: Workspace, goal: Goal) throws {
        let entity = WorkspaceMapper.toEntity(workspace, context: CDStack.viewContext)
        
        var goals = workspace.goals
        goals.removeAll{ $0.id == goal.id }
        
        if let prioritizedGoal = entity.prioritizedGoal {
            goals.append(GoalMapper.mapToDomain(from: prioritizedGoal))
        }
        
        let entityGoals = goals.map { GoalMapper.toEntity(from: $0, context: CDStack.viewContext)}
        
        entity.goals = NSSet(array: entityGoals)
        entity.prioritizedGoal = GoalMapper.toEntity(from: goal, context: CDStack.viewContext)
        
        CDStack.saveContext()
    }
    
    func unprioritizeGoal(in workspace: Workspace) throws {
        let entity = WorkspaceMapper.toEntity(workspace, context: CDStack.viewContext)
        
        var goals = workspace.goals
        
        guard let prioritizedGoal = workspace.prioritizedGoal else { return }
        goals.append(prioritizedGoal)
        
        let goalEntities = goals.map { GoalMapper.toEntity(from: $0, context: CDStack.viewContext) }
        
        entity.goals = NSSet(array: goalEntities)
        entity.prioritizedGoal = nil
        CDStack.saveContext()
    }
}
