//
//  DeleteGoalUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol DeleteGoalUseCase {
    func execute(_ goal: Goal) throws
}
