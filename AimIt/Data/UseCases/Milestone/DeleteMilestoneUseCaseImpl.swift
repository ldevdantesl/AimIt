//
//  DeleteMilestoneUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

final class DeleteMilestoneUseCaseImpl: DeleteMilestoneUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(_ milestone: Milestone) throws {
        try repository.deleteMilestone(milestone)
    }
}
