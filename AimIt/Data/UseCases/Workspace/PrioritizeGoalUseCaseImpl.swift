//
//  PrioritizeGoalUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 3.01.2025.
//

import Foundation

final class PrioritizeGoalUseCaseImpl: PrioritizeGoalUseCase {
    private let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func execute(in workspace: Workspace, goal: Goal) throws {
        try repository.prioritizeGoal(in: workspace, goal: goal)
    }
}
