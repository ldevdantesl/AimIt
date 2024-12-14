//
//  GoalCardView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AIGoalCardView: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    
    var goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        Button(action: { coordinator.push(to: .goalDetails(goal))}) {
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
                    Text(desc)
                        .font(.system(.caption, design: .rounded, weight: .bold))
                        .foregroundStyle(.aiBlack.opacity(0.8))
                        .lineLimit(1)
                        .padding(.bottom, 20)
                }
                
                AIProgressBar(goal: goal)
                    .padding(.bottom, 10)
            }
            .padding([.horizontal, .top], 20)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 120)
            .background(Color.aiLabel, in: .rect(cornerRadius: 25))
            .padding(.horizontal)
            .shadow(color: .aiSecondary2.opacity(0.2), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    AIGoalCardView(goal: .sample)
        .preferredColorScheme(.dark)
        .environmentObject(HomeCoordinator())
}
