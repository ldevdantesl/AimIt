//
//  AIGoalWidget.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation
import SwiftUI

struct AIGoalWidget: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    
    private let workspace: Workspace
    
    init(workspace: Workspace) {
        self.workspace = workspace
        self.goal = workspace.goals.max {
            $0.milestones.count < $1.milestones.count
        }
    }
    
    @State private var goal: Goal?
    
    var body: some View {
        Button {
            if let goal {
                let bindingGoal = Binding(get: { goal }, set: { self.goal = $0 })
                coordinator.push(to: .goalDetails(bindingGoal))
            } else {
                coordinator.push(to: .addGoal)
            }
        } label: {
            VStack(alignment: goal == nil ? .center : .leading, spacing: 1){
                if let goal = goal {
                    Text(goal.title)
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiBlack)
                        .lineLimit(1)
                    milestonesList()
                    Spacer()
                } else {
                    Text("No goals")
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiSecondary2)
                    
                    Text("Add One +")
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiBlack)
                }
            }
            .padding(.horizontal, 15)
            .padding(.top, 10)
            .frame(maxWidth: UIConstants.widgetWidth, alignment: goal == nil ? .center : .topLeading)
            .frame(maxHeight: UIConstants.widgetHeight)
            .background(Color.aiLabel, in: .rect(cornerRadius: UIConstants.widgetCornerRadius))
            .padding(.leading, 20)
        }
    }
    
    @ViewBuilder
    func milestonesList() -> some View {
        if let goal = goal {
            if goal.milestones.isEmpty {
                Text("No Milestones")
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiSecondary2)
            } else {
                ScrollView{
                    LazyVStack(spacing: 2){
                        ForEach(goal.milestones) { milestone in
                            milestoneRow(milestone: milestone)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .scrollIndicators(.hidden)
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
                .foregroundStyle(.aiBlack)
            
            Text(milestone.desc)
                .font(.system(.subheadline, design: .rounded, weight: .light))
                .foregroundStyle(.aiSecondary2)
                .strikethrough(milestone.isCompleted)
                .lineLimit(1)
            
            Spacer()
        }
    }
}

#Preview {
    AIGoalWidget(workspace: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(HomeCoordinator())
        .environmentObject(DIContainer().makeGoalViewModel())
}
