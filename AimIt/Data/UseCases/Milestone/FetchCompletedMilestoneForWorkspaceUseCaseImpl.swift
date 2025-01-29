//
//  FetchCompletedMilestoneForWorkspaceUseCaseimpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import Foundation

final class FetchCompletedMilestoneForWorkspaceUseCaseImpl: FetchCompletedMilestoneForWorkspaceUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(_ workspace: Workspace) throws -> [Milestone] {
        try repository.fetchCompletedMilestoneForWorkspace(workspace)
    }
}
