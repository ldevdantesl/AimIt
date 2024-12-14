//
//  WorkspaceRepository.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

protocol WorkspaceRepository {
    func fetchWorkspaces() throws -> [Workspace]
    func fetchCurrentWorkspace(by id: UUID) throws -> Workspace
    func addWorkspace(title: String) throws -> Workspace
    func deleteWorkspace(_ workspace: Workspace) throws
    func editWorkspace(workspace: Workspace, newTitle: String, newGoals: [Goal]) throws
}
