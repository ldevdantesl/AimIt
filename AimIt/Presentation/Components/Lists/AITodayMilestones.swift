//
//  AITodayMilestones.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 9.01.2025.
//

import SwiftUI

struct AITodayMilestones: View {
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    @State private var milestones: [Milestone] = []
    
    private let workspace: Workspace
    
    init(workspace: Workspace) {
        self.workspace = workspace
    }
    
    var body: some View {
        VStack(spacing: 15){
            VStack(alignment:.leading){
                Text("Today")
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiLabel)
                
                Text("Milestones for Today: \(DeadlineFormatter.formatToDayMonth(.now))")
                    .font(.system(.footnote, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if milestones.isEmpty {
                NotFoundView(
                    imageName: ImageNames.noGoals,
                    title: "No milestones for today",
                    verticalPadding: 60,
                    subtitle: "Great.. You have nothing to do for today.",
                    action: nil
                )
            } else {
                ForEach(milestones) { milestone in
                    AIMilestoneCard(milestone: milestone)
                }
            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            self.milestones = milestoneVM.fetchTodayMilestonesForWorkspace(for: workspace)
        }
        .id(workspace)
    }
}

#Preview {
    AITodayMilestones(workspace: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
