//
//  GoalsViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation
import SwiftUI

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
    
    func addGoal(title: String, desc: String? = nil, deadline: Date?) {
        do {
            try addGoalUseCase.execute(title: title, desc: desc, deadline: deadline)
            fetchGoals()
        } catch {
            errorMsg = "Error Adding Goal: \(error.localizedDescription)"
        }
    }
    
    func deleteGoal(_ goal: Goal) {
        do {
            try deleteGoalUseCase.execute(goal)
            fetchGoals()
        } catch {
            errorMsg = "Error deleting Goal: \(error.localizedDescription)"
        }
    }
    
    func editGoals(_ goal: Goal, title: String, desc: String? = nil, deadline: Date?) {
        do {
            try editGoalUseCase.execute(goal, newTitle: title, newDesc: desc, newDeadline: deadline)
            fetchGoals()
        } catch {
            errorMsg = "Error editing Goal: \(error.localizedDescription)"
        }
    }
    
    func fetchGoals() {
        do {
            goals = try fetchGoalsUseCase.execute()
        } catch {
            errorMsg = "Error fetching Goals: \(error.localizedDescription)"
        }
    }
    
    func completeGoal(_ goal: Goal) {
        do {
            try toggleCompletionGoalUseCase.execute(goal, completing: true)
            fetchGoals()
        } catch {
            errorMsg = "Error completing Goal: \(error.localizedDescription)"
        }
    }
    
    func uncompleteGoal(_ goal: Goal) {
        do {
            try toggleCompletionGoalUseCase.execute(goal, completing: false)
            fetchGoals()
        } catch {
            errorMsg = "Error uncompleting Goal: \(error.localizedDescription)"
        }
    }
}
