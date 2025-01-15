//
//  AnalyticsCalculateMonthlyDataForMilestonesUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation

final class AnalyticsCalculateMonthlyDataForMilestonesUseCaseImpl: AnalyticsCalculateMonthlyDataForMilestonesUseCase {
    private let repository: AnalyticsRepository
    
    init(repository: AnalyticsRepository) {
        self.repository = repository
    }
    
    func execute(in workspace: Workspace) throws -> [AnalyticsMonthlyData] {
        try repository.calculateMonthlyDataForMilestones(in: workspace)
    }
}
