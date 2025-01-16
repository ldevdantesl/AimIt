//
//  AnalyticsCalculateMonthlyDataForCompletedMilestonesUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import Foundation

final class AnalyticsCalculateMonthlyDataForCompletedMilestonesUseCaseImpl: AnalyticsCalculateMonthlyDataForCompletedMilestonesUseCase {
    private let repository: AnalyticsRepository
    
    init(repository: AnalyticsRepository) {
        self.repository = repository
    }
    
    func execute(in workspace: Workspace) throws -> [AnalyticsMonthlyData] {
        try repository.calculateMonthlyDataForCompletedMilestones(in: workspace)
    }
}
