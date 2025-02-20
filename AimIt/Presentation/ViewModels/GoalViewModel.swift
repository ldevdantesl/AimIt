//
//  GoalsViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation
import SwiftUI

@MainActor
final class GoalViewModel: ObservableObject {
    @Published var errorMsg: String?
    
    private let addGoalUseCase: AddGoalUseCase
    private let deleteGoalUseCase: DeleteGoalUseCase
    private let editGoalUseCase: EditGoalUseCase
    private let fetchGoalsUseCase: FetchGoalsUseCase
    private let fetchGoalByIDUseCase: FetchGoalByIDUseCase
    private let fetchGoalsByPromptUseCase: FetchGoalsByPromptUseCase
    private let fetchCompletedGoalsForWorkspaceUseCase: FetchCompletedGoalsForWorkspaceUseCase
    private let toggleCompletionGoalUseCase: ToggleCompletionGoalUseCase
    
    init(
        addGoalUseCase: AddGoalUseCase,
        deleteGoalUseCase: DeleteGoalUseCase,
        editGoalUseCase: EditGoalUseCase,
        fetchGoalsUseCase: FetchGoalsUseCase,
        fetchGoalByIDUseCase: FetchGoalByIDUseCase,
        fetchGoalsByPromptUseCase: FetchGoalsByPromptUseCase,
        fetchCompletedGoalsForWorkspaceUseCase: FetchCompletedGoalsForWorkspaceUseCase,
        toggleCompletionGoalUseCase: ToggleCompletionGoalUseCase
    ) {
        self.addGoalUseCase = addGoalUseCase
        self.deleteGoalUseCase = deleteGoalUseCase
        self.editGoalUseCase = editGoalUseCase
        self.fetchGoalsUseCase = fetchGoalsUseCase
        self.fetchGoalByIDUseCase = fetchGoalByIDUseCase
        self.fetchGoalsByPromptUseCase = fetchGoalsByPromptUseCase
        self.fetchCompletedGoalsForWorkspaceUseCase = fetchCompletedGoalsForWorkspaceUseCase
        self.toggleCompletionGoalUseCase = toggleCompletionGoalUseCase
    }
    
    // MARK: - FETCHING
    func fetchGoals() -> [Goal] {
        handleUseCase(errorMessage: "Error fetching Goals", defaultValue: [], action: fetchGoalsUseCase.execute)
    }
    
    func fetchGoalByID(id: UUID) -> Goal? {
        handleUseCase(errorMessage: "Error fetching goal by id", defaultValue: nil) {
            try fetchGoalByIDUseCase.execute(id: id)
        }
    }
    
    func fetchGoalByPrompt(with prompt: String, in workspace: Workspace) -> [Goal] {
        handleUseCase(errorMessage: "Error fetching goal by prompt", defaultValue: []) {
            try fetchGoalsByPromptUseCase.execute(with: prompt, in: workspace)
        }
    }
    
    func fetchCompletedGoalsForWorkspace(_ workspace: Workspace) -> [Goal] {
        handleUseCase(errorMessage: "Error fetching completed goals for workspace", defaultValue: []) {
            try fetchCompletedGoalsForWorkspaceUseCase.execute(workspace)
        }
    }
    
    // MARK: - ADDING
    func addGoal(
        to workspace: Workspace,
        title: String,
        desc: String? = nil,
        deadline: Date?,
        milestones: [Milestone]
    ) {
        handleUseCase(errorMessage: "Error Adding Goal") {
            try addGoalUseCase.execute(
                to: workspace,
                title: title,
                desc: desc,
                deadline: deadline,
                milestones: milestones
            )
        }
    }
    
    // MARK: - EDITING
    @discardableResult
    func editGoal(
        _ goal: Goal,
        title: String? = nil,
        desc: String? = nil,
        deadline: Date? = nil,
        newMilestones: [Milestone]? = nil
    ) -> Goal? {
        handleUseCase(errorMessage: "Erorr editing Goal", defaultValue: nil) {
            try editGoalUseCase.execute(
                goal,
                newTitle: title,
                newDesc: desc,
                newDeadline: deadline,
                newMilestones: newMilestones
            )
        }
    }
    
    // MARK: - DELETING
    func deleteGoal(_ goal: Goal) {
        handleUseCase(errorMessage: "Error deleting Goal") {
            try deleteGoalUseCase.execute(goal)
        }
    }
    
    // MARK: - COMPLETION
    func completeGoal(_ goal: Goal) {
        handleUseCase(errorMessage: "Error completing Goal:") {
            try toggleCompletionGoalUseCase.execute(goal, completing: true)
        }
    }
    
    func uncompleteGoal(_ goal: Goal) {
        handleUseCase(errorMessage: "Error uncompleting Goal:") {
            try toggleCompletionGoalUseCase.execute(goal, completing: false)
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
