//
//  AnalyticsAverageGoalCompletionTimeUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

final class AnalyticsAverageGoalCompletionTimeUseCaseImpl: AnalyticsAverageGoalCompletionTimeUseCase {
    private let repository: AnalyticsRepository
    
    init(repository: AnalyticsRepository) {
        self.repository = repository
    }
    
    func execute(in workspace: Workspace) throws -> TimeInterval {
        try repository.averageGoalCompletionTime(in: workspace)
    }
}
