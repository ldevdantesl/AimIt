//
//  AnalyticsCalculateMonthlyDataForMilestonesUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation

protocol AnalyticsCalculateMonthlyDataForMilestonesUseCase {
    func execute(in workspace: Workspace) throws -> [AnalyticsMonthlyData]
}
