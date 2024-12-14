//
//  GoalDetailsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

struct GoalDetailsView: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    
    @State var goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        ScrollView{
            AIHeaderView(
                leftButton: AIButton(
                    image: .back,
                    action: coordinator.goBack
                ),
                rightButton: AIButton(
                    image: .edit,
                    backColor: .accentColor,
                    foreColor: .aiLabel
                ),
                title: "Goal",
                subtitle: "\(goal.title)"
            )
            
            Spacer(minLength: 20)
            
            AIInfoField(title: "Title", info: goal.title, infoFontStyle: .headline)
            
            Spacer(minLength: 20)
            
            if let description = goal.desc, !description.isEmpty {
                AIInfoField(
                    title: "Description",
                    info: description,
                    infoFontStyle: .headline,
                    infoForeColor: .aiSecondary2
                )
                Spacer(minLength: 20)
            }
            
            
            AIInfoField(
                title: "Deadline",
                info: "\(DeadlineFormatter.formatToDayMonth(goal.deadline)) - \(DeadlineFormatter.formatToDaysLeft(goal.deadline))",
                infoFontStyle: .headline,
                infoForeColor: DeadlineFormatter.threeDaysLeft(goal.deadline) ? .red : .aiLabel
            )
            
            Spacer(minLength: 30)
            
            
            AIGoalMilestonesList(goal: $goal)
                .padding(.bottom, 20)
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: goal.isCompleted ? "Uncomplete" : "Complete") {
                    goal.isCompleted ? goalVM.uncompleteGoal(goal) : goalVM.completeGoal(goal)
                    goal.isCompleted.toggle()
                }
            }
        }
        .onDisappear {
            goalVM.fetchGoals()
        }
    }
}

#Preview {
    NavigationStack{
        GoalDetailsView(goal: .sample)
            .background(Color.aiBackground)
            .environmentObject(HomeCoordinator())
            .environmentObject(DIContainer().makeGoalViewModel())
    }
}
