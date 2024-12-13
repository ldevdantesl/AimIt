//
//  GoalCardView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AICardView: View {
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
                        .font(.system(.title3, design: .rounded, weight: .bold))
                        .foregroundStyle(.aiBlack)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if let deadline = goal.deadline {
                        Text(DeadlineFormatter.formatToDayMonth(date: deadline))
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiBlack)
                    }
                }
                
                Text(goal.desc ?? "")
                    .font(.system(.caption, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiBlack.opacity(0.8))
                    .lineLimit(2)
                
                Spacer()
                
                AIProgressBar(goal: goal)
                    .padding(.vertical, 20)
            }
            .padding([.horizontal, .top], 20)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 140)
            .background(Color.aiLabel, in: .rect(cornerRadius: 15))
            .padding(.horizontal)
            .shadow(color: .aiSecondary2.opacity(0.2), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    AICardView(goal: .sample)
        .preferredColorScheme(.dark)
        .environmentObject(HomeCoordinator())
}
