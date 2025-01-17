//
//  GoalCardView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AIGoalCard: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    
    @State private var goal: Goal
    private var prioritized: Bool
    
    init(goal: Goal) {
        self.goal = goal
        self.prioritized = false
    }
    
    init(prioritizedGoal: Goal) {
        self.goal = prioritizedGoal
        self.prioritized = true
    }
    
    private var isDeadlinePassed:Bool {
        DeadlineFormatter.isDayPassed(goal.deadline)
    }
    
    var body: some View {
        Button(action: {
            coordinator.push(to: .goalDetails($goal))
        } ) {
            VStack(alignment: .leading) {
                HStack{
                    Text(goal.title)
                        .font(.system(.headline, design: .rounded, weight: .bold))
                        .foregroundStyle(isDeadlinePassed ? .aiLabel : .aiBlack)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(DeadlineFormatter.formatToDayMonth(goal.deadline))
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundStyle(isDeadlinePassed ? .aiLabel : .aiBlack)
                }
                
                if let desc = goal.desc{
                    Text(desc.isEmpty ? "No description for this goal" : desc)
                        .font(.system(.caption, design: .rounded, weight: .bold))
                        .foregroundStyle(isDeadlinePassed ? .aiLabel.opacity(0.8) : .aiBlack.opacity(0.8))
                        .lineLimit(1)
                        .padding(.bottom, 20)
                }
                
                if isDeadlinePassed {
                    HStack{
                        Text("Deadline is passed")
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiLabel)
                        
                        Spacer()
                        
                        Image(ImageNames.warning)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.bottom, 10)
                } else {
                    AIGoalProgressBar(goal: goal)
                        .padding(.bottom, 10)
                }
            }
            .padding([.horizontal, .top], 20)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 120)
            .background(isDeadlinePassed ? Color.aiLightBrown.gradient : Color.aiLabel.gradient, in: .rect(cornerRadius: 25))
            .padding(.horizontal)
            .shadow(color: .aiSecondary2.opacity(0.2), radius: 2, x: 0, y: 1)
            .overlay(alignment: .topTrailing) {
                if prioritized {
                    Image(.pin)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 10)
                        .offset(y: -10)
                }
            }
        }
    }
}

#Preview {
    AIGoalCard(goal: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(HomeCoordinator())
        .environmentObject(DIContainer().makeGoalViewModel())
}
