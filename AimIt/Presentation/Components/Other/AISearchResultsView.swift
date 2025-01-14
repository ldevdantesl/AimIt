//
//  AISearchResultsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import SwiftUI

struct AISearchResultsView: View {
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    
    private let workspace: Workspace
    @Binding private var searchText: String
    
    @State private var goals: [Goal]
    @State private var milestones: [Milestone]
    
    init(searchText: Binding<String>, in workspace: Workspace) {
        self.workspace = workspace
        self._searchText = searchText
        self.goals = []
        self.milestones = []
    }
    
    var body: some View {
        LazyVStack {
            if !goals.isEmpty {
                VStack(spacing: 10){
                    Text("Goals: ")
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiSecondary2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    ForEach(goals) { goal in
                        AIGoalCard(goal: goal)
                    }
                }
                Spacer(minLength: 40)
            }
            
            if !milestones.isEmpty {
                VStack(spacing: 10){
                    Text("Milestones: ")
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiSecondary2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    ForEach(milestones) { milestone in
                        AIMilestoneCard(milestone: milestone)
                            .padding(.horizontal, 20)
                    }
                }
            }
            
            if milestones.isEmpty && goals.isEmpty {
                NotFoundView(
                    imageName: ImageNames.noFound,
                    title: "No results for '\(searchText)'",
                    verticalPadding: 60,
                    subtitle: "Check spelling and try again",
                    action: clearPrompt
                )
            }
        }
        .onChange(of: searchText) { newValue in
            withAnimation {
                DispatchQueue.main.async {
                    self.goals = goalVM.fetchGoalByPrompt(with: searchText, in: workspace)
                    self.milestones = milestoneVM.fetchMilestonesByPrompt(with: searchText, in: workspace)
                }
            }
        }
    }
    
    private func clearPrompt() {
        self.searchText = ""
    }
}

#Preview {
    AISearchResultsView(searchText: .constant(""), in: .sample)
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(DIContainer().makeMilestoneViewModel())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
