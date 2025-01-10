//
//  AIMilestoneCard.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 10.01.2025.
//

import SwiftUI

struct AIMilestoneCard: View {
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    @EnvironmentObject var goalVM: GoalViewModel
    
    @State var milestone: Milestone
    @State private var milestoneGoal: Goal? = nil
    
    init(milestone: Milestone) {
        self.milestone = milestone
    }
    
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: milestone.systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(.aiBlack)
            
            VStack(alignment: .leading) {
                if let title = milestoneGoal?.title {
                    Text("\(title)")
                        .font(.system(.caption, design: .rounded, weight: .bold))
                        .foregroundStyle(.aiSecondary2)
                        .lineLimit(1)
                }
                Text(milestone.desc)
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .lineLimit(1)
                    .foregroundStyle(.aiBlack)
            }
            
            Spacer()
            
            Button{
                withAnimation {
                    milestone.isCompleted.toggle()
                    milestoneVM.toggleMilestoneCompletion(milestone)
                    workspaceVM.fetchCurrentWorkspace()
                }
            } label:{
                Image(systemName: milestone.isCompleted ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(milestone.isCompleted ? .accent : .aiSecondary2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
        .padding(.horizontal, 10)
        .background(Color.aiLabel, in:.rect(cornerRadius: UIConstants.widgetCornerRadius - 5))
        .onAppear {
            if let goalID = milestone.goalID {
                milestoneGoal = goalVM.fetchGoalByID(id: goalID)
            }
        }
    }
}

#Preview {
    AIMilestoneCard(milestone: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
        .environmentObject(DIContainer().makeGoalViewModel())
}
