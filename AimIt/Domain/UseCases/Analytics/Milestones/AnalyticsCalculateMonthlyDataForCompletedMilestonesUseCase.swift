//
//  AnalyticsCalculateMonthlyDataForCompletedMilestonesUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import Foundation

protocol AnalyticsCalculateMonthlyDataForCompletedMilestonesUseCase {
    func execute(in workspace: Workspace) throws -> [AnalyticsMonthlyData]
}
