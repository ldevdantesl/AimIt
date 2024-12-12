//
//  EditWorkspaceUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

final class EditWorkspaceUseCaseImpl: EditWorkspaceUseCase {
    let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func execute(_ workspace: Workspace, newTitle: String, newGoals: [Goal]) throws {
        try repository.editWorkspace(workspace: workspace, newTitle: newTitle, newGoals: newGoals)
    }
}
