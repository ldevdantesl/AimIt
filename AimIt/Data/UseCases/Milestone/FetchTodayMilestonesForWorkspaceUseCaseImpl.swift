//
//  FetchMilestonesForDayUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 9.01.2025.
//

import Foundation

final class FetchTodayMilestonesForWorkspaceUseCaseImpl: FetchTodayMilestonesForWorkspaceUseCase {
    private let repository: MilestoneRepository
    
    init(repository: MilestoneRepository) {
        self.repository = repository
    }
    
    func execute(for workspace: Workspace, date: Date) throws -> [Milestone] {
        try repository.fetchTodayMilestonesForWorkspace(for: workspace, date: date)
    }
}
