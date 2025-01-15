//
//  FetchTotalGoalsUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

protocol AnalyticsFetchTotalGoalsUseCase {
    func execute(in workspace: Workspace) throws -> Int
}
