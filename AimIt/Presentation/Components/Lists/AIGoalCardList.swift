//
//  AICardList.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIGoalCardList: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @EnvironmentObject var goalVM: GoalViewModel
    
    var body: some View {
        if workspaceVM.currentWorkspace.goals.isEmpty {
            NotFoundView(
                imageName: ImageNames.noGoals,
                title: "No goals yet",
                topPadding: 40,
                subtitle: "Tap once to add new goal",
                action: addOneGoal
            )
        } else {
            LazyVStack(spacing: 20) {
                ForEach(workspaceVM.currentWorkspace.goals, id: \.self) { goal in
                    if goal != workspaceVM.currentWorkspace.prioritizedGoal {
                        AIGoalCard(goal: goal)
                            .contextMenu {
                                Button(
                                    "Prioritize",
                                    systemImage: "exclamationmark",
                                    action: { prioritizeGoal(goal: goal) }
                                )
                                Button(
                                    "Delete",
                                    systemImage: "trash.fill",
                                    role:.destructive,
                                    action: { deleteGoal(goal: goal)}
                                )
                            }
                            .transition(.move(edge: .top))
                    }
                }
            }
        }
    }
    
    private func prioritizeGoal(goal: Goal) {
        DispatchQueue.main.async {
            withAnimation(.bouncy) {
                workspaceVM.prioritizeGoal(workspaceVM.currentWorkspace, goal: goal)
            }
        }
    }
    
    private func deleteGoal(goal: Goal) {
        DispatchQueue.main.async {
            withAnimation {
                goalVM.deleteGoal(goal)
                workspaceVM.fetchCurrentWorkspace()
            }
        }
    }
    
    private func addOneGoal() {
        coordinator.push(to: .addGoal)
    }
}

#Preview {
    AIGoalCardList()
        .environmentObject(HomeCoordinator())
        .environmentObject(DIContainer().makeWorkspaceViewModel())
        .environmentObject(DIContainer().makeGoalViewModel())
}
