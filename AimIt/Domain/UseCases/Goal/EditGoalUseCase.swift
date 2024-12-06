//
//  EditGoalUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol EditGoalUseCase {
    func execute(
        _ goal: Goal,
        newTitle: String?,
        newDesc: String?,
        newDeadline: Date?
    ) throws
}
