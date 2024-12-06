//
//  FetchAllMilestonesUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class FetchAllMilestonesUseCaseImpl: FetchAllMilestonesUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute() throws -> [Milestone] {
        try repository.fetchAllMilestones()
    }
}
