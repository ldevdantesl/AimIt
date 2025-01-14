//
//  FetchGoalsByPromptUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

final class FetchGoalsByPromptUseCaseImpl: FetchGoalsByPromptUseCase {
    private let repository: GoalRepository
    
    init(repository: GoalRepository) {
        self.repository = repository
    }
    
    func execute(with prompt: String, in workspace: Workspace) throws -> [Goal] {
        try repository.fetchGoalsByPrompt(with: prompt, in: workspace)
    }
}
