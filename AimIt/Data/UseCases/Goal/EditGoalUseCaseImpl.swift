//
//  EditGoalUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class EditGoalUseCaseImpl: EditGoalUseCase {
    private let repository: GoalRepository
    
    init(repository: GoalRepository) {
        self.repository = repository
    }

    func execute(
        _ goal: Goal,
        newTitle: String?,
        newDesc: String?,
        newDeadline: Date?
    ) throws {
        try repository.editGoal(goal, newTitle: newTitle, newDesc: newDesc, newDeadline: newDeadline)
    }
}
