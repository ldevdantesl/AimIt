//
//  DeleteWorkspaceUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

final class DeleteWorkspaceUseCaseImpl: DeleteWorkspaceUseCase {
    let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func execute(_ workspace: Workspace) throws {
        try repository.deleteWorkspace(workspace)
    }
}
