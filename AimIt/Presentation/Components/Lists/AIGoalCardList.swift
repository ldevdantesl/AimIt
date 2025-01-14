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
    
    private let workspace: Workspace
    
    init(in workspace: Workspace) {
        self.workspace = workspace
    }
    
    var body: some View {
        if workspace.goals.isEmpty && workspace.prioritizedGoal == nil {
            NotFoundView(
                imageName: ImageNames.noGoals,
                title: "No goals yet",
                verticalPadding: 60,
                subtitle: "Tap once to add new goal",
                action: addOneGoal
            )
        } else {
            LazyVStack(spacing: 20) {
                ForEach(workspace.goals, id: \.self) { goal in
                    AIGoalCard(goal: goal)
                        .contextMenu {
                            if workspace.prioritizedGoal == nil {
                                Button(
                                    "Prioritize",
                                    systemImage: "exclamationmark",
                                    action: { prioritizeGoal(goal: goal) }
                                )
                            }
                            Button(
                                "Delete",
                                systemImage: "trash.fill",
                                role:.destructive,
                                action: { deleteGoal(goal: goal)}
                            )
                        }
                }
            }
        }
    }
    
    private func prioritizeGoal(goal: Goal) {
        DispatchQueue.main.async {
            withAnimation {
                workspaceVM.prioritizeGoal(workspace, goal: goal)
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
    AIGoalCardList(in: .sample)
        .environmentObject(HomeCoordinator())
        .environmentObject(DIContainer().makeWorkspaceViewModel())
        .environmentObject(DIContainer().makeGoalViewModel())
}
