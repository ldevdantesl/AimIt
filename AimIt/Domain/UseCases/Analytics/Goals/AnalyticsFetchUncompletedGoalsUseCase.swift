//
//  AnalyticsFetchUncompletedGoals.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

protocol AnalyticsFetchUncompletedGoalsUseCase {
    func execute(in workspace: Workspace) throws -> [Goal]
}
