//
//  CreateSeparateMilestoneUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 9.01.2025.
//

import Foundation

final class CreateSeparateMilestoneUseCaseImpl: CreateSeparateMilestoneUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(desc: String, systemImage: String, dueDate: Date?, completed: Bool) throws -> Milestone {
        try repository.createSeparateMilestone(desc: desc, systemImage: systemImage, dueDate: dueDate, completed: completed)
    }
}
