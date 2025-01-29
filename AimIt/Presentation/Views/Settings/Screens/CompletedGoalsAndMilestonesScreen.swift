//
//  CompletedGoalsAndMilestonesScreen.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import SwiftUI

struct CompletedGoalsAndMilestonesScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var coordinator: SettingsCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    @State private var isGoal: Bool = true
    @State private var goals: [Goal] = []
    @State private var milestones: [Milestone] = []
    @State private var selectedWorkspace: Workspace = .sample
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                AIHeaderView(
                    leftButton: AIButton(
                        image: .back,
                        backColor: .aiSecondary,
                        foreColor: .aiLabel,
                        action: coordinator.goBack
                    ),
                    rightMenu: AIButton(
                        image: .briefCase,
                        backColor: userVM.themeColor,
                        foreColor: Color.aiLabel
                    ),
                    title: "In Workspace",
                    subtitle: selectedWorkspace.title,
                    menuContent: workspaceSelector
                )
                .contentTransition(.numericText())
                
                AIGoalOrMilestoneSelector(isGoal: $isGoal)
                
                if isGoal {
                    if goals.isEmpty {
                        NotFoundView(
                            imageName: ImageNames.noCompleted,
                            title: "No completed Goals",
                            verticalPadding: 100,
                            subtitle: "Complete any Goal to see it here.",
                            action: nil
                        )
                    } else {
                        ForEach(goals) { goal in
                            AICompletedGoalCard(goal: goal)
                        }
                    }
                } else {
                    if milestones.isEmpty {
                        NotFoundView(
                            imageName: ImageNames.noCompleted,
                            title: "No completed Milestones",
                            verticalPadding: 100,
                            subtitle: "Complete any Milestone to see it here.",
                            action: nil
                        )
                    } else {
                        ForEach(milestones) { milestone in
                            AICompletedMilestoneCard(milestone: milestone)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
        .onAppear(perform: setup)
        .background(Color.aiBackground)
        .navigationBarBackButtonHidden()
        .onChange(of: selectedWorkspace) { newValue in
            withAnimation {
                self.selectedWorkspace = newValue
                self.goals = goalVM.fetchCompletedGoalsForWorkspace(newValue)
                self.milestones = milestoneVM.fetchCompletedMilestonesForWorkspace(newValue)
            }
        }
    }
    
    @ViewBuilder
    private func workspaceSelector() -> some View {
        Text("Select Workspace")
        
        ForEach(workspaceVM.workspaces) { workspace in
            if workspace.id != selectedWorkspace.id {
                Button{
                    withAnimation { self.selectedWorkspace = workspace }
                } label: {
                    Text(workspace.title)
                }
            }
        }
    }
    
    private func setup() {
        withAnimation {
            self.selectedWorkspace = workspaceVM.currentWorkspace
            self.goals = goalVM.fetchCompletedGoalsForWorkspace(selectedWorkspace)
            self.milestones = milestoneVM.fetchCompletedMilestonesForWorkspace(selectedWorkspace)
        }
    }
}

#Preview {
    CompletedGoalsAndMilestonesScreen()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(SettingsCoordinator())
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(DIContainer().makeMilestoneViewModel())
        .environmentObject(DIContainer().makeWorkspaceViewModel())
}
