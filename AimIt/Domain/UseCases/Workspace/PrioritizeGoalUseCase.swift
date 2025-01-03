//
//  PrioritizeGoalUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 3.01.2025.
//

import Foundation

protocol PrioritizeGoalUseCase {
    func execute(in workspace: Workspace, goal: Goal) throws
}
