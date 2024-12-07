//
//  GoalCardView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct GoalCardView: View {
    var goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill()
            .foregroundStyle(.aiBackground)
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .padding(.horizontal, 20)
            .overlay(alignment: .top) {
                HStack{
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 30)
                        .foregroundStyle(.aiBrown)
                    
                    VStack(alignment: .leading) {
                        Text(goal.title)
                            .font(.system(.title3, design: .rounded, weight: .bold))
                            .foregroundStyle(.aiLabel)
                            .lineLimit(2)
                        
                        Text(goal.desc ?? "")
                            .font(.system(.caption, design: .rounded, weight: .bold))
                            .foregroundStyle(.aiSecondary)
                            .lineLimit(3)
                    }
                }
                .padding(20)
            }
            .overlay(alignment: .bottom) {
                AIProgressBar(milestones: goal.milestones)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 15)
            }
    }
}

#Preview {
    GoalCardView(goal: .sample)
}
