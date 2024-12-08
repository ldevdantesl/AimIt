//
//  AddGoalUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class AddGoalUseCaseImpl: AddGoalUseCase {
    private let repository: GoalRepository
    
    init(repository: GoalRepository) {
        self.repository = repository
    }
    
    func execute(title: String, desc: String?, deadline: Date?, milestones: [Milestone]) throws {
        try repository.addGoal(title: title, desc: desc, deadline: deadline, milestones: milestones)
    }
}
