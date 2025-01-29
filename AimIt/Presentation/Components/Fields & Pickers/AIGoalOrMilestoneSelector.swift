//
//  AIGoalOrMilestoneSelector.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import SwiftUI

struct AIGoalOrMilestoneSelector: View {
    
    @Binding private var isGoal: Bool

    init(isGoal: Binding<Bool>) {
        self._isGoal = isGoal
    }
    
    var body: some View {
        HStack{
            Button {
                withAnimation(.bouncy) { isGoal = true }
            } label:  {
                Text("Goals")
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundStyle(isGoal ? .aiBlack : .aiLabel)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(isGoal ? Color.aiBeige : Color.aiSecondary, in: .capsule)
            }
            
            Button {
                withAnimation(.bouncy) { isGoal = false }
            } label: {
                Text("Milestones")
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundStyle(!isGoal ? .aiBlack : .aiLabel)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(!isGoal ? Color.aiBeige : Color.aiSecondary, in: .capsule)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIGoalOrMilestoneSelector(isGoal: .constant(true))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
