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
        VStack(alignment: .leading){
            Text(goal.title)
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .foregroundStyle(.aiBlack)
         
            milestonesList()
        }
        .padding(15)
        .frame(maxWidth: UIConstants.widgetWidth, alignment: .topLeading)
        .frame(maxHeight: UIConstants.widgetHeight)
        .background(Color.aiLabel, in: .rect(cornerRadius: UIConstants.widgetCornerRadius))
        .padding(.leading, 20)
    }
    
    @ViewBuilder
    func milestonesList() -> some View {
        ScrollView{
            ForEach(goal.milestones) { milestone in
                milestoneRow(milestone: milestone)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func milestoneRow(milestone: Milestone) -> some View {
        HStack{
            Image(systemName: milestone.isCompleted ? "checkmark.circle.fill" :  "circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.aiBlack)
            
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
