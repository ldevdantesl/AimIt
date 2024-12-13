//
//  AddWorkspaceUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

final class AddWorkspaceUseCaseImpl: AddWorkspaceUseCase {
    let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func execute(title: String, goals: [Goal]) throws -> Workspace {
        try repository.addWorkspace(title: title, goals: goals)
    }
}
