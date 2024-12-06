//
//  ToggleCompletionGoalUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol ToggleCompletionGoalUseCase {
    func execute(_ goal: Goal, completing: Bool) throws
}
