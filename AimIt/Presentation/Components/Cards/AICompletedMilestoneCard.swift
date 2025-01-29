//
//  AICompletedMilestoneCard.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import SwiftUI

struct AICompletedMilestoneCard: View {
    @EnvironmentObject var goalVM: GoalViewModel
    @State private var milestoneGoal: Goal? = nil
    
    private let milestone: Milestone
    
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
            
            if let completedAt = milestone.completedAt {
                VStack {
                    Text(DeadlineFormatter.formatToDayMonth(completedAt))
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiBlack)
                        
                    Text("Completed:")
                        .font(.system(.caption2, design: .rounded, weight: .light))
                        .foregroundStyle(.aiSecondary2)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
        .padding(.horizontal, 10)
        .background(Color.aiBeige, in:.rect(cornerRadius: UIConstants.widgetCornerRadius - 5))
        .onAppear(perform: setup)
    }
    
    private func setup() {
        if let goalID = milestone.goalID {
            milestoneGoal = goalVM.fetchGoalByID(id: goalID)
        }
    }
}

#Preview {
    AICompletedMilestoneCard(milestone: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeGoalViewModel())
}
