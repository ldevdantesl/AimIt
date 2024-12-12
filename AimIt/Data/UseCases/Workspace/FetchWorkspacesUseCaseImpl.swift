//
//  FetchWorkspacesUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

final class FetchWorkspacesUseCaseImpl: FetchWorkspacesUseCase {
    let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func execute() throws -> [Workspace] {
        try repository.fetchWorkspaces()
    }
    
}
