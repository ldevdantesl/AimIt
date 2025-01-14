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
    private let toggleCompletionGoalUseCase: ToggleCompletionGoalUseCase
    
    init(
        addGoalUseCase: AddGoalUseCase,
        deleteGoalUseCase: DeleteGoalUseCase,
        editGoalUseCase: EditGoalUseCase,
        fetchGoalsUseCase: FetchGoalsUseCase,
        fetchGoalByIDUseCase: FetchGoalByIDUseCase,
        fetchGoalsByPromptUseCase: FetchGoalsByPromptUseCase,
        toggleCompletionGoalUseCase: ToggleCompletionGoalUseCase
    ) {
        self.addGoalUseCase = addGoalUseCase
        self.deleteGoalUseCase = deleteGoalUseCase
        self.editGoalUseCase = editGoalUseCase
        self.fetchGoalsUseCase = fetchGoalsUseCase
        self.fetchGoalByIDUseCase = fetchGoalByIDUseCase
        self.fetchGoalsByPromptUseCase = fetchGoalsByPromptUseCase
        self.toggleCompletionGoalUseCase = toggleCompletionGoalUseCase
    }
    
    // MARK: - FETCHING
    func fetchGoals() -> [Goal] {
        do {
            return try fetchGoalsUseCase.execute()
        } catch {
            errorMsg = "Error fetching Goals: \(error.localizedDescription)"
            print(errorMsg ?? "")
            return []
        }
    }
    
    func fetchGoalByID(id: UUID) -> Goal? {
        do {
            return try fetchGoalByIDUseCase.execute(id: id)
        } catch {
            errorMsg = "Error fetching goal by id: \(error.localizedDescription)"
            return nil
        }
    }
    
    func fetchGoalByPrompt(with prompt: String, in workspace: Workspace) -> [Goal] {
        do {
            return try fetchGoalsByPromptUseCase.execute(with: prompt, in: workspace)
        } catch {
            errorMsg = "Error fetching goal by prompt: \(error.localizedDescription)"
            print(errorMsg ?? "")
            return []
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
    func editGoal(
        _ goal: Goal,
        title: String,
        desc: String? = nil,
        deadline: Date?,
        newMilestones: [Milestone]
    ) -> Goal? {
        do {
            return try editGoalUseCase.execute(
                goal,
                newTitle: title,
                newDesc: desc,
                newDeadline: deadline,
                newMilestones: newMilestones
            )
        } catch {
            errorMsg = "Erorr editing Goal: \(error.localizedDescription)"
            print(errorMsg ?? "")
            return nil
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
        }
    }
}
