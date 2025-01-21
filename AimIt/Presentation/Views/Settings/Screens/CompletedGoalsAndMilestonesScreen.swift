//
//  CompletedGoalsAndMilestonesScreen.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import SwiftUI

struct CompletedGoalsAndMilestonesScreen: View {
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
                        backColor: Color.accentColor,
                        foreColor: Color.aiLabel
                    ),
                    title: "In Workspace",
                    subtitle: selectedWorkspace.title,
                    menuContent: workspaceSelector
                )
                .contentTransition(.numericText())
                
                AIGoalOrMilestoneSelector(isGoal: $isGoal)
                
                if goals.isEmpty {
                    NotFoundView(
                        imageName: ImageNames.noCompleted,
                        title: "No completed \(isGoal ? "Goals" : "Milestones")",
                        verticalPadding: 100,
                        subtitle: "Complete any \(isGoal ? "Goal" : "Milestone") to see it here.",
                        action: nil
                    )
                    .contentTransition(.numericText())
                } else { }
            }
        }
        .onAppear {
            withAnimation {
                selectedWorkspace = workspaceVM.currentWorkspace
            }
        }
        .background(Color.aiBackground)
        .navigationBarBackButtonHidden()
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
