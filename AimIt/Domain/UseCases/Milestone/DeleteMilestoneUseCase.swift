//
//  DeleteMilestoneUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol DeleteMilestoneUseCase {
    func execute(_ milestone: Milestone) throws
}
