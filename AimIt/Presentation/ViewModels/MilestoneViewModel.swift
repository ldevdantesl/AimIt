//
//  MilestoneViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation
import SwiftUI

final class MilestoneViewModel: ObservableObject {
    @Published var milestones: [Milestone] = []
    @Published var errorMsg: String?
    
    private let addMilestoneUseCase: AddMilestoneUseCase
    private let deleteMilestoneUseCase: DeleteMilestoneUseCase
    private let fetchAllMilestonesUseCase: FetchAllMilestonesUseCase
    private let fetchMilestonesForGoalUseCase: FetchMilestonesForGoalUseCase
    private let toggleMilestoneCompletionUseCase: ToggleMilestoneCompletionUseCase
    private let updateMilestoneUseCase: UpdateMilestoneUseCase
    
    init(
        addMilestoneUseCase: AddMilestoneUseCase,
        deleteMilestoneUseCase: DeleteMilestoneUseCase,
        fetchAllMilestonesUseCase: FetchAllMilestonesUseCase,
        fetchMilestonesForGoalUseCase: FetchMilestonesForGoalUseCase,
        toggleMilestoneCompletionUseCase: ToggleMilestoneCompletionUseCase,
        updateMilestoneUseCase: UpdateMilestoneUseCase
    ) {
        self.addMilestoneUseCase = addMilestoneUseCase
        self.deleteMilestoneUseCase = deleteMilestoneUseCase
        self.fetchAllMilestonesUseCase = fetchAllMilestonesUseCase
        self.fetchMilestonesForGoalUseCase = fetchMilestonesForGoalUseCase
        self.toggleMilestoneCompletionUseCase = toggleMilestoneCompletionUseCase
        self.updateMilestoneUseCase = updateMilestoneUseCase
    }
    
    func addMilestone(desc: String, to goal: Goal) {
        do {
            try addMilestoneUseCase.execute(desc: desc, to: goal)
        } catch {
            errorMsg = "Error adding milestone: \(error.localizedDescription)"
            print("Error adding milestone: \(error.localizedDescription)")
        }
    }
    
    func deleteMilestone(_ milestone: Milestone) {
        do {
            try deleteMilestoneUseCase.execute(milestone)
        } catch {
            errorMsg = "Error deleting milestone: \(error.localizedDescription)"
            print("Error deleting milestone: \(error.localizedDescription)")
        }
    }
    
    func fetchAllMilestones() -> [Milestone] {
        do {
            return try fetchAllMilestonesUseCase.execute()
        } catch {
            errorMsg = "Error fetching milestones: \(error.localizedDescription)"
            print("Error fetching milestones: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchMilestonesForGoal(_ goal: Goal) {
        do {
            milestones = try fetchMilestonesForGoalUseCase.execute(for: goal)
        } catch {
            errorMsg = "Error fetching milestones for goal: \(error.localizedDescription)"
            print("Error fetching milestones for goal: \(error.localizedDescription)")
        }
    }
    
    func toggleMilestoneCompletion(_ milestone: Milestone) {
        do {
            try toggleMilestoneCompletionUseCase.execute(milestone)
        } catch {
            errorMsg = "Error toggling milestone completion: \(error.localizedDescription)"
            print("Error toggling milestone completion: \(error.localizedDescription)")
        }
    }

    func updateMilestone(_ milestone: Milestone, desc: String) {
        do {
            try updateMilestoneUseCase.execute(milestone, desc: desc)
        } catch {
            errorMsg = "Error updating milestone: \(error.localizedDescription)"
            print("Error updating milestone: \(error.localizedDescription)")
        }
    }
}
