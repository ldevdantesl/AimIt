//
//  AICompletedMilestoneAnalytics.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import SwiftUI

struct AICompletedMilestoneAnalytics: View {
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    @State private var completedMilestoneWithinWeek: [Milestone] = []
    
    var body: some View {
        VStack{
            if !completedMilestoneWithinWeek.isEmpty{
                AIInfoField(title: "Milestones completed within this week", info: nil)
                
                VStack(spacing: 10){
                    ForEach(completedMilestoneWithinWeek) { milestone in
                        AIMilestoneCard(milestone: milestone, isTogglable: false)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .onAppear(perform: setup)
    }
    
    private func setup() {
        DispatchQueue.main.async {
            withAnimation {
                self.completedMilestoneWithinWeek = analyticsVM.fetchMilestonesCompletedWithinWeek(in: workspace)
            }
        }
    }
}

#Preview {
    AICompletedMilestoneAnalytics(analyticsVM: DIContainer().makeAnalyticsViewModel(), workspace: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
