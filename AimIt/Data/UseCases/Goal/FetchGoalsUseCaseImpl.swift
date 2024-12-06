//
//  FetchGoalsUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class FetchGoalsUseCaseImpl: FetchGoalsUseCase {
    private let repository: GoalRepository
    
    init(repository: GoalRepository) {
        self.repository = repository
    }
    
    func execute() throws -> [Goal] {
        try repository.fetchGoals()
    }
}
