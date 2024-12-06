//
//  FetchMilestonesForGoalUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class FetchMilestonesForGoalUseCaseImpl: FetchMilestonesForGoalUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(for goal: Goal) throws -> [Milestone] {
        try repository.fetchMilestones(for: goal)
    }
}
