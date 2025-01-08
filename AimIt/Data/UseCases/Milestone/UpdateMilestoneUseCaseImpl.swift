//
//  UpdateMilestoneUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class UpdateMilestoneUseCaseImpl: UpdateMilestoneUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(_ milestone: Milestone, desc: String?, systemImage: String?, dueDate: Date?) throws {
        try repository.updateMilestone(milestone, desc: desc, systemImage: systemImage, dueDate: dueDate)
    }
}
