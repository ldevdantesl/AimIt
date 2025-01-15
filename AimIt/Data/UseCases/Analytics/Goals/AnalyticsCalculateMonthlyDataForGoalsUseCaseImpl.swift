//
//  AnalyticsCalculateMonthlyDataForGoalsUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation

final class AnalyticsCalculateMonthlyDataForGoalsUseCaseImpl: AnalyticsCalculateMonthlyDataForGoalsUseCase {
    private let repository: AnalyticsRepository
    
    init(repository: AnalyticsRepository) {
        self.repository = repository
    }
    
    func execute(in workspace: Workspace) throws -> [AnalyticsMonthlyData] {
        try repository.calculateMonthlyDataForGoals(in: workspace)
    }
}
