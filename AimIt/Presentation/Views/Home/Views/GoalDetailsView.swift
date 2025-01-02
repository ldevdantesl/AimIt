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
                    foreColor: .aiLabel,
                    action: {
                        coordinator.present(fullScreenCover: .editGoal)
                    }
                ),
                title: "Goal",
                subtitle: "\(goalVM.selectedGoal.title)"
            )
            
            Spacer(minLength: 20)
            
            AIInfoField(title: "Title", info: goalVM.selectedGoal.title, infoFontStyle: .headline)
            
            Spacer(minLength: 20)
            
            if let description = goalVM.selectedGoal.desc, !description.isEmpty {
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
                info: "\(DeadlineFormatter.formatToDayMonth(goalVM.selectedGoal.deadline)) - \(DeadlineFormatter.formatToDaysLeft(goalVM.selectedGoal.deadline))",
                infoFontStyle: .headline,
                infoForeColor: DeadlineFormatter.threeDaysLeft(goalVM.selectedGoal.deadline) ? .red : .aiLabel
            )
            
            Spacer(minLength: 30)
            
            AIGoalMilestonesList()
                .padding(.bottom, 20)
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: goalVM.selectedGoal.isCompleted ? "Uncomplete" : "Complete") {
                    goalVM.selectedGoal.isCompleted ? goalVM.uncompleteGoal(goalVM.selectedGoal) : goalVM.completeGoal(goalVM.selectedGoal)
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
        GoalDetailsView()
            .background(Color.aiBackground)
            .environmentObject(HomeCoordinator())
            .environmentObject(DIContainer().makeGoalViewModel())
    }
}
