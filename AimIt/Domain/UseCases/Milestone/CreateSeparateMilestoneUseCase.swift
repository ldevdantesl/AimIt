//
//  CreateMilestoneUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 9.01.2025.
//

import Foundation

protocol CreateSeparateMilestoneUseCase {
    func execute(desc: String, systemImage: String, dueDate: Date? ,completed: Bool) throws -> Milestone
}
