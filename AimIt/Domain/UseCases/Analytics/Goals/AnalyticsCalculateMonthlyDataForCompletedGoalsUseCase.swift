//
//  AnalyticsCalculateMonthlyDataForCompletedGoalsUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation

protocol AnalyticsCalculateMonthlyDataForCompletedGoalsUseCase {
    func execute(in workspace: Workspace) throws -> [AnalyticsMonthlyData]
}
