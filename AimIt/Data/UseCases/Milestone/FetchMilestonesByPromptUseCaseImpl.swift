//
//  FetchMilestonesByPromptUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

final class FetchMilestonesByPromptUseCaseImpl: FetchMilestonesByPromptUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(with prompt: String, in workspace: Workspace) throws -> [Milestone] {
        try repository.fetchMilestonesByPrompt(with: prompt, in: workspace)
    }
}
