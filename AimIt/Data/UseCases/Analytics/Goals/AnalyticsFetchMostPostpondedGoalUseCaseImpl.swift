//
//  AnalyticsFetchMostPostpondedGoalUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import Foundation

final class AnalyticsFetchMostPostpondedGoalUseCaseImpl: AnalyticsFetchMostPostpondedGoalUseCase {
    private let repository: AnalyticsRepository
    
    init(repository: AnalyticsRepository) {
        self.repository = repository
    }
    
    func execute(in workspace: Workspace) throws -> Goal? {
        try repository.fetchMostPostpondedGoal(in: workspace)
    }
}
