//
//  UnprioritizeGoalUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 3.01.2025.
//

import Foundation

final class UnprioritizeGoalUseCaseImpl: UnprioritizeGoalUseCase {
    private let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func execute(in workspace: Workspace) throws {
        try repository.unprioritizeGoal(in: workspace)
    }
}
