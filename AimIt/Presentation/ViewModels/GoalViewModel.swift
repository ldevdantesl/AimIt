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
    @Published var goals: [Goal] = []
    @Published var errorMsg: String?
    
    private let addGoalUseCase: AddGoalUseCase
    private let deleteGoalUseCase: DeleteGoalUseCase
    private let editGoalUseCase: EditGoalUseCase
    private let fetchGoalsUseCase: FetchGoalsUseCase
    private let toggleCompletionGoalUseCase: ToggleCompletionGoalUseCase
    
    init(
        addGoalUseCase: AddGoalUseCase,
        deleteGoalUseCase: DeleteGoalUseCase,
        editGoalUseCase: EditGoalUseCase,
        fetchGoalsUseCase: FetchGoalsUseCase,
        toggleCompletionGoalUseCase: ToggleCompletionGoalUseCase
    ) {
        self.addGoalUseCase = addGoalUseCase
        self.deleteGoalUseCase = deleteGoalUseCase
        self.editGoalUseCase = editGoalUseCase
        self.fetchGoalsUseCase = fetchGoalsUseCase
        self.toggleCompletionGoalUseCase = toggleCompletionGoalUseCase
        
        fetchGoals()
    }
    
    // MARK: - FETCHING
    func fetchGoals() {
        do {
            goals = try fetchGoalsUseCase.execute()
        } catch {
            errorMsg = "Error fetching Goals: \(error.localizedDescription)"
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
        handleUseCase(errorMessage: "Error Adding Goal", fetchAfter: true) {
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
        handleUseCase(errorMessage: "Error deleting Goal", fetchAfter: true) {
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
    private func handleUseCase(errorMessage: String, fetchAfter: Bool = false, action: () throws -> ()) {
        do {
            try action()
            fetchAfter ? fetchGoals() : ()
        } catch  {
            self.errorMsg = "\(errorMessage): \(error.localizedDescription)"
        }
    }
}
