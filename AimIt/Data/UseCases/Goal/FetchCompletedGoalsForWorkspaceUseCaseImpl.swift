//
//  FetchCompletedGoalsUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import Foundation

final class FetchCompletedGoalsForWorkspaceUseCaseImpl: FetchCompletedGoalsForWorkspaceUseCase {
    private let repository: GoalRepository
    
    init(repository: GoalRepository) {
        self.repository = repository
    }
    
    func execute(_ workspace: Workspace) throws -> [Goal] {
        try repository.fetchCompletedGoalsForWorkspace(workspace)
    }
}
