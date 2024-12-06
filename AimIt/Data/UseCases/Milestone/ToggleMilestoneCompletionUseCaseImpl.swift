//
//  ToggleMilestoneCompletionUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class ToggleMilestoneCompletionUseCaseImpl: ToggleMilestoneCompletionUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(_ milestone: Milestone) throws {
        try repository.toggleMilestoneCompletion(milestone)
    }
}
