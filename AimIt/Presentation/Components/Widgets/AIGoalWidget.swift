//
//  AIGoalWidget.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation
import SwiftUI

struct AIGoalWidget: View {
    let goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text(goal.title)
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .foregroundStyle(.aiLabel)
         
            milestonesList()
        }
    }
    
    @ViewBuilder
    func milestonesList() -> some View {
        VStack{
            ForEach(goal.milestones) { milestone in
                milestoneRow(milestone: milestone)
            }
        }
    }
    
    @ViewBuilder
    func milestoneRow(milestone: Milestone) -> some View {
        HStack{
            Image(systemName: milestone.isCompleted ? "checkmark.circle.fill" :  "circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.aiLabel)
            
            Text(milestone.desc)
                .font(.system(.subheadline, design: .rounded, weight: .light))
                .foregroundStyle(.aiSecondary2)
                .strikethrough(milestone.isCompleted)
        }
    }
}

#Preview {
    AIGoalWidget(goal: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
