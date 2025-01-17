//
//  AIMiniGoalCard.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import SwiftUI

struct AIMiniGoalCard: View {
    
    private let goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(goal.title)
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiBlack)
                    .lineLimit(1)
                
                Spacer()
                
                Text(DeadlineFormatter.formatToDayMonth(goal.deadline))
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiBlack)
            }
            
            if let desc = goal.desc{
                Text(desc.isEmpty ? "No description for this goal" : desc)
                    .font(.system(.caption, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiBlack.opacity(0.8))
                    .lineLimit(1)
                    .padding(.bottom, 20)
            }
        }
        .padding([.horizontal, .top], 20)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 80)
        .background(Color.aiBeige.gradient, in: .rect(cornerRadius: 25))
        .padding(.horizontal)
        .shadow(color: .aiSecondary2.opacity(0.2), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    AIMiniGoalCard(goal: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
