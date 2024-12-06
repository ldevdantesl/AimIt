//
//  UpdateMilestoneUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol UpdateMilestoneUseCase {
    func execute(_ milestone: Milestone, desc: String) throws
}
