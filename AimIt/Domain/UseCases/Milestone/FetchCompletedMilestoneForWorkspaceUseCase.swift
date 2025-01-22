//
//  FetchCompletedMilestoneForWorkspaceUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import Foundation

protocol FetchCompletedMilestoneForWorkspaceUseCase {
    func execute(_ workspace: Workspace) throws -> [Milestone]
}
