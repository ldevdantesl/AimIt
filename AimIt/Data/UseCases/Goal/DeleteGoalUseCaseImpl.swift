//
//  DeleteGoalUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class DeleteGoalUseCaseImpl: DeleteGoalUseCase {
    private let repository: GoalRepository
    
    init(repository: GoalRepository) {
        self.repository = repository
    }
    
    func execute(_ goal: Goal) throws {
        try repository.deleteGoal(goal)
    }
}
