//
//  FetchTodayMilestonesUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 9.01.2025.
//

import Foundation

protocol FetchTodayMilestonesForWorkspaceUseCase {
    func execute(for workspace: Workspace, date: Date) throws -> [Milestone]
}
