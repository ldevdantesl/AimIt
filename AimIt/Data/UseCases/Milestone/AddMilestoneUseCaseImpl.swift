//
//  AddMilestoneUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class AddMilestoneUseCaseImpl: AddMilestoneUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(desc: String, systemImage: String, completed: Bool, to goal: Goal) throws {
        try repository.addMilestone(desc: desc, systemImage: systemImage, completed: completed, to: goal)
    }
}
