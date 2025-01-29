//
//  AnalyticsFetchUncompletedMilestonesUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

final class AnalyticsFetchUncompletedMilestonesUseCaseImpl: AnalyticsFetchUncompletedMilestonesUseCase {
    private let repository: AnalyticsRepository
    
    init(repository: AnalyticsRepository) {
        self.repository = repository
    }
    
    func execute(in workspace: Workspace) throws -> [Milestone] {
        try repository.fetchUncompletedMilestones(in: workspace)
    }
}
