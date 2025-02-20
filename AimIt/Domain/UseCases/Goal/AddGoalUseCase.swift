//
//  AddGoalUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol AddGoalUseCase {
    func execute(
        to workspace: Workspace,
        title: String,
        desc: String?,
        deadline: Date?,
        milestones: [Milestone]
    ) throws
}

