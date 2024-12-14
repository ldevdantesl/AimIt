//
//  AICardList.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIGoalCardList: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    var goals: [Goal] = []
    
    var workspaceGoals: [Goal] {
        goals.sorted { $0.milestones.count < $1.milestones.count }
    }
    
    var body: some View {
        if workspaceGoals.isEmpty {
            NotFoundView(
                imageName: ImageNames.noGoals,
                title: "No goals yet",
                topPadding: 40,
                subtitle: "Tap once to add new goal",
                action: addOneGoal
            )
        } else {
            LazyVStack(spacing: 20) {
                ForEach(goals, id: \.self) { goal in
                    AIGoalCardView(goal: goal)
                }
            }
        }
    }
    
    private func addOneGoal() {
        coordinator.push(to: .addGoal)
    }
}

#Preview {
    AIGoalCardList(goals: [])
        .environmentObject(HomeCoordinator())
}
