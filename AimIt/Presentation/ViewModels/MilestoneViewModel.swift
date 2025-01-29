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
    private let fetchMilestonesByPromptUseCase: FetchMilestonesByPromptUseCase
    private let fetchCompletedMilestoneForWorkspaceUseCase: FetchCompletedMilestoneForWorkspaceUseCase
    
    private let toggleMilestoneCompletionUseCase: ToggleMilestoneCompletionUseCase
    private let createSeperateMilestoneUseCase: CreateSeparateMilestoneUseCase
    
    init(
        addMilestoneUseCase: AddMilestoneUseCase,
        deleteMilestoneUseCase: DeleteMilestoneUseCase,
        fetchAllMilestonesUseCase: FetchAllMilestonesUseCase,
        fetchMilestonesForGoalUseCase: FetchMilestonesForGoalUseCase,
        fetchTodayMilestonesForWorkspaceUseCase: FetchTodayMilestonesForWorkspaceUseCase,
        fetchMilestonesByPromptUseCase: FetchMilestonesByPromptUseCase,
        fetchCompletedMilestoneForWorkspaceUseCase: FetchCompletedMilestoneForWorkspaceUseCase,
        toggleMilestoneCompletionUseCase: ToggleMilestoneCompletionUseCase,
        updateMilestoneUseCase: UpdateMilestoneUseCase,
        createSeperateMilestoneUseCase: CreateSeparateMilestoneUseCase
    ) {
        self.addMilestoneUseCase = addMilestoneUseCase
        self.deleteMilestoneUseCase = deleteMilestoneUseCase
        self.fetchAllMilestonesUseCase = fetchAllMilestonesUseCase
        self.fetchMilestonesForGoalUseCase = fetchMilestonesForGoalUseCase
        self.fetchTodayMilestonesForWorkspaceUseCase = fetchTodayMilestonesForWorkspaceUseCase
        self.fetchMilestonesByPromptUseCase = fetchMilestonesByPromptUseCase
        self.fetchCompletedMilestoneForWorkspaceUseCase = fetchCompletedMilestoneForWorkspaceUseCase
        self.toggleMilestoneCompletionUseCase = toggleMilestoneCompletionUseCase
        self.updateMilestoneUseCase = updateMilestoneUseCase
        self.createSeperateMilestoneUseCase = createSeperateMilestoneUseCase
    }
    
    // MARK: - FETCHING
    func fetchAllMilestones() -> [Milestone] {
        handleUseCase(errorMessage: "Error fetching milestones", defaultValue: [], action: fetchAllMilestonesUseCase.execute)
    }
    
    func fetchMilestonesForGoal(_ goal: Goal) {
        handleUseCase(errorMessage: "Error fetching milestones for goal") {
            self.milestones = try fetchMilestonesForGoalUseCase.execute(for: goal)
        }
    }
    
    func fetchCompletedMilestonesForWorkspace(_ workspace: Workspace) -> [Milestone] {
        handleUseCase(errorMessage: "Error fetching completed milestones for workspace", defaultValue: []) {
            try fetchCompletedMilestoneForWorkspaceUseCase.execute(workspace)
        }
    }
    
    func fetchTodayMilestonesForWorkspace(for workspace: Workspace, date: Date = .now) -> [Milestone] {
        handleUseCase(errorMessage: "Error fetching milestones for goal", defaultValue: []) {
            try fetchTodayMilestonesForWorkspaceUseCase.execute(for: workspace, date: date)
        }
    }
    
    func fetchMilestonesByPrompt(with prompt: String, in workspace: Workspace) -> [Milestone] {
        handleUseCase(errorMessage: "Error fetching milestones for prompt", defaultValue: []) {
            try fetchMilestonesByPromptUseCase.execute(with: prompt, in: workspace)
        }
    }
    
    // MARK: - ADDING
    func addMilestone(desc: String, systemImage: String, dueDate: Date?, completed: Bool = false, to goal: Goal) {
        handleUseCase(errorMessage: "Error adding milestone") {
            try addMilestoneUseCase.execute(
                desc: desc,
                systemImage: systemImage,
                dueDate: dueDate,
                completed: completed,
                to: goal
            )
            fetchMilestonesForGoal(goal)
        }
    }
    
    // MARK: - EDITING
    func updateMilestone(
        _ milestone: Milestone,
        desc: String? = nil,
        systemImage: String? = nil,
        dueDate: Date? = nil
    ) {
        handleUseCase(errorMessage: "Error updating milestone") {
            try updateMilestoneUseCase.execute(
                milestone,
                desc: desc,
                systemImage: systemImage,
                dueDate: dueDate
            )
        }
    }
    
    // MARK: - DELETING
    func deleteMilestone(_ milestone: Milestone) {
        handleUseCase(errorMessage: "Error deleting milestone") {
            try deleteMilestoneUseCase.execute(milestone)
        }
    }
    
    // MARK: - COMPLETION
    func toggleMilestoneCompletion(_ milestone: Milestone) {
        handleUseCase(errorMessage: "Error toggling milestone completion") {
            try toggleMilestoneCompletionUseCase.execute(milestone)
        }
    }

    // MARK: - OTHER
    func createSeperateMilestone(
        desc: String,
        systemImage: String,
        dueDate: Date?,
        completed: Bool = false
    ) -> Milestone? {
        handleUseCase(errorMessage: "Error creating seperate milestone", defaultValue: nil) {
            try createSeperateMilestoneUseCase.execute(
                desc: desc,
                systemImage: systemImage,
                dueDate: dueDate,
                completed: completed
            )
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func handleUseCase(errorMessage: String, action: () throws -> ()) {
        do {
            try action()
        } catch  {
            self.errorMsg = "\(errorMessage): \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    private func handleUseCase<T>(errorMessage: String, defaultValue: T, action: () throws -> T) -> T {
        do {
            return try action()
        } catch  {
            self.errorMsg = "\(errorMessage): \(error.localizedDescription)"
            print(errorMsg ?? "")
            return defaultValue
        }
    }
}
