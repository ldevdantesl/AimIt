//
//  WorkspaceRepository.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

protocol WorkspaceRepository {
    func fetchWorkspaces() throws -> [Workspace]
    func fetchCurrentWorkspace(by id: UUID, sortSystem: (GoalEntity, GoalEntity) -> Bool) throws -> Workspace
    func addWorkspace(title: String) throws -> Workspace
    func deleteWorkspace(_ workspace: Workspace) throws
    func editWorkspace(workspace: Workspace, newTitle: String, newGoals: [Goal]) throws
    func prioritizeGoal(in workspace: Workspace, goal: Goal) throws
    func unprioritizeGoal(in workspace: Workspace) throws
}
