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
        Button(action: { coordinator.navigateTo(screen: .goalDetails(goal))}) {
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.aiLabel)
                    
                    Text(goal.title)
                        .font(.system(.title3, design: .rounded, weight: .bold))
                        .foregroundStyle(.aiLabel)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if let deadline = goal.deadline {
                        Text(DeadlineFormatter.formatToDayMonth(date: deadline))
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiLabel)
                    }
                }
                
                Text(goal.desc ?? "")
                    .font(.system(.caption, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiLabel.opacity(0.8))
                    .lineLimit(2)
                
                Spacer()
                
                AIProgressBar(goal: goal)
                    .padding(.vertical, 20)
            }
            .padding([.horizontal, .top], 20)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 130)
            .background(Color.aiSecondary, in: .rect(cornerRadius: 15))
            .padding(.horizontal)
            .shadow(color: .aiLabel.opacity(0.2), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    AICardView(goal: .sample)
        .preferredColorScheme(.dark)
        .environmentObject(DIContainer().makeAppCoordinator().makeHomeCoordinator())
}
