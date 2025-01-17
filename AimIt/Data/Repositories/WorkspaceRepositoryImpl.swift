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
    
    var localizedDescription: String {
        switch self {
        case .workspaceNotFound:
            return "Workspace with this id is not found"
        case .workspaceGoalsNotFound:
            return "Workspace goals with this id is not found"
        }
    }
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
            throw WorkspaceRepositoryErrors.workspaceNotFound
        }
        
        let sortedGoals: [Goal]
        if let goalSet = workspace.goals as? Set<GoalEntity>, !goalSet.isEmpty {
            sortedGoals = goalSet
                .filter { !$0.isCompleted }
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
            throw CoreDataErrors.failedToDeleteFromContext
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
        entity.prioritizedGoal = GoalMapper.toEntity(from: goal, context: CDStack.viewContext)
        
        CDStack.saveContext()
    }
    
    func unprioritizeGoal(in workspace: Workspace) throws {
        let entity = WorkspaceMapper.toEntity(workspace, context: CDStack.viewContext)
        entity.prioritizedGoal = nil
        CDStack.saveContext()
    }
}
