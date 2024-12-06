//
//  ToggleCompletionGoalUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class ToggleCompletionGoalUseCaseImpl: ToggleCompletionGoalUseCase {
    private let repository: GoalRepository
    
    init(repository: GoalRepository) {
        self.repository = repository
    }
    
    func execute(_ goal: Goal, completing: Bool) throws {
        try completing ? repository.completeGoal(goal) : repository.uncompleteGoal(goal)
    }
}
