//
//  AnalyticsAverageGoalCompletionTime.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

protocol AnalyticsAverageGoalCompletionTimeUseCase {
    func execute(in workspace: Workspace) throws -> TimeInterval
}
