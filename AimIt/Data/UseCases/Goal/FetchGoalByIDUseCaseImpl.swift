//
//  FetchGoalByIDUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 10.01.2025.
//

import Foundation

final class FetchGoalByIDUseCaseImpl: FetchGoalByIDUseCase {
    private let repository: GoalRepository
    
    init(repository: GoalRepository) {
        self.repository = repository
    }
    
    func execute(id: UUID) throws -> Goal {
        try repository.fetchGoalByID(id: id)
    }
}
