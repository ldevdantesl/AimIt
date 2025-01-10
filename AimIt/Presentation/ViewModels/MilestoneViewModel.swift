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
    private let updateMilestoneUseCase: UpdateMilestoneUseCase
    
    private let fetchMilestonesForGoalUseCase: FetchMilestonesForGoalUseCase
    private let fetchTodayMilestonesForWorkspaceUseCase: FetchTodayMilestonesForWorkspaceUseCase
    private let toggleMilestoneCompletionUseCase: ToggleMilestoneCompletionUseCase
    private let createSeperateMilestoneUseCase: CreateSeparateMilestoneUseCase
    
    init(
        addMilestoneUseCase: AddMilestoneUseCase,
        deleteMilestoneUseCase: DeleteMilestoneUseCase,
        fetchAllMilestonesUseCase: FetchAllMilestonesUseCase,
        fetchMilestonesForGoalUseCase: FetchMilestonesForGoalUseCase,
        fetchTodayMilestonesForWorkspaceUseCase: FetchTodayMilestonesForWorkspaceUseCase,
        toggleMilestoneCompletionUseCase: ToggleMilestoneCompletionUseCase,
        updateMilestoneUseCase: UpdateMilestoneUseCase,
        createSeperateMilestoneUseCase: CreateSeparateMilestoneUseCase
    ) {
        self.addMilestoneUseCase = addMilestoneUseCase
        self.deleteMilestoneUseCase = deleteMilestoneUseCase
        self.fetchAllMilestonesUseCase = fetchAllMilestonesUseCase
        self.fetchMilestonesForGoalUseCase = fetchMilestonesForGoalUseCase
        self.fetchTodayMilestonesForWorkspaceUseCase = fetchTodayMilestonesForWorkspaceUseCase
        self.toggleMilestoneCompletionUseCase = toggleMilestoneCompletionUseCase
        self.updateMilestoneUseCase = updateMilestoneUseCase
        self.createSeperateMilestoneUseCase = createSeperateMilestoneUseCase
    }
    
    // MARK: - FETCHING
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
    
    func fetchTodayMilestonesForWorkspace(for workspace: Workspace, date: Date = .now) -> [Milestone] {
        do {
            return try fetchTodayMilestonesForWorkspaceUseCase.execute(for: workspace, date: date)
        } catch {
            errorMsg = "Error fetching milestones for goal: \(error.localizedDescription)"
            print(errorMsg ?? "")
            return []
        }
    }
    
    // MARK: - ADDING
    func addMilestone(desc: String, systemImage: String, dueDate: Date?, completed: Bool = false, to goal: Goal) {
        do {
            try addMilestoneUseCase.execute(
                desc: desc,
                systemImage: systemImage,
                dueDate: dueDate,
                completed: completed,
                to: goal
            )
            fetchMilestonesForGoal(goal)
        } catch {
            errorMsg = "Error adding milestone: \(error.localizedDescription)"
            print("Error adding milestone: \(error.localizedDescription)")
        }
    }
    
    // MARK: - EDITING
    func updateMilestone(
        _ milestone: Milestone,
        desc: String? = nil,
        systemImage: String? = nil,
        dueDate: Date? = nil
    ) {
        do {
            try updateMilestoneUseCase.execute(
                milestone,
                desc: desc,
                systemImage: systemImage,
                dueDate: dueDate
            )
        } catch {
            errorMsg = "Error updating milestone: \(error.localizedDescription)"
            print("Error updating milestone: \(error.localizedDescription)")
        }
    }
    
    // MARK: - DELETING
    func deleteMilestone(_ milestone: Milestone) {
        do {
            try deleteMilestoneUseCase.execute(milestone)
        } catch {
            errorMsg = "Error deleting milestone: \(error.localizedDescription)"
            print("Error deleting milestone: \(error.localizedDescription)")
        }
    }
    
    // MARK: - COMPLETION
    func toggleMilestoneCompletion(_ milestone: Milestone) {
        do {
            try toggleMilestoneCompletionUseCase.execute(milestone)
        } catch {
            errorMsg = "Error toggling milestone completion: \(error.localizedDescription)"
            print("Error toggling milestone completion: \(error.localizedDescription)")
        }
    }

    // MARK: - OTHER
    func createSeperateMilestone(
        desc: String,
        systemImage: String,
        dueDate: Date?,
        completed: Bool = false
    ) -> Milestone? {
        do {
            return try createSeperateMilestoneUseCase.execute(
                desc: desc,
                systemImage: systemImage,
                dueDate: dueDate,
                completed: completed
            )
        } catch {
            errorMsg = "Error creating seperate milestone: \(error.localizedDescription)"
            print(errorMsg ?? "")
            return nil
        }
    }
}
