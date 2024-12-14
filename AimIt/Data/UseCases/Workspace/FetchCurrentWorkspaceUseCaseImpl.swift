//
//  FetchCurrentWorkspaceUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import Foundation

final class FetchCurrentWorkspaceUseCaseImpl: FetchCurrentWorkspaceUseCase {
    private let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func execute(by id: UUID) throws -> Workspace {
        try repository.fetchCurrentWorkspace(by: id)
    }
}
