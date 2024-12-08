//
//  GoalCardView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AICardView: View {
    var goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill()
            .foregroundStyle(.aiSecondary)
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .overlay(alignment: .top) {
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
                        .foregroundStyle(.aiSecondary)
                        .lineLimit(2)
                }
                .padding([.horizontal, .top], 20)
            }
            .overlay(alignment: .bottom) {
                AIProgressBar(goal: goal)
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 20)
    }
}

#Preview {
    AICardView(goal: .sample)
}
