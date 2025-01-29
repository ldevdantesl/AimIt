//
//  AnalyticsFetchMostPostpondedGoalUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import Foundation

protocol AnalyticsFetchMostPostpondedGoalUseCase {
    func execute(in workspace: Workspace) throws -> Goal?
}
