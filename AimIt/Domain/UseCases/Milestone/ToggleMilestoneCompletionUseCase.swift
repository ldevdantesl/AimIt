//
//  ToggleMilestoneCompletionUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol ToggleMilestoneCompletionUseCase {
    func execute(_ milestone: Milestone) throws
}
