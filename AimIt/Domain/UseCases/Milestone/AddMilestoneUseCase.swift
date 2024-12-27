//
//  AddMilestoneUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol AddMilestoneUseCase {
    func execute(desc: String, systemImage: String, completed: Bool, to goal: Goal) throws
}
