//
//  FetchMilestonesByPromptUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

protocol FetchMilestonesByPromptUseCase {
    func execute(with prompt: String, in workspace: Workspace) throws -> [Milestone]
}
