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
    
    @Binding private var goal: Goal
    
    init(goal: Binding<Goal>) {
        self._goal = goal
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
                    foreColor: .aiLabel,
                    action: {
                        coordinator.present(fullScreenCover: .editGoal($goal))
                    }
                ),
                title: "Goal",
                subtitle: "\(goal.title)"
            )
            
            Spacer(minLength: 20)
            
            AIInfoField(
                title: "Title",
                info: goal.title,
                infoFontStyle: .headline
            )
            
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
            
            AIDateCard(
                createdDate: goal.createdAt,
                date: goal.deadline
            )
            
            Spacer(minLength: 30)
            
            if goal.milestones.isEmpty {
                NotFoundView(
                    imageName: ImageNames.noMilestones,
                    title: "Oops...",
                    topPadding: 100,
                    subtitle: "You have no milestones",
                    action: nil
                )
            } else {
                AIGoalMilestonesList(goalMilestones: $goal.milestones)
                    .padding(.bottom, 20)
            }
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: goal.isCompleted ? "Uncomplete" : "Complete") {
                    goal.isCompleted ? goalVM.uncompleteGoal(goal) : goalVM.completeGoal(goal)
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
        GoalDetailsView(goal: .constant(.sample))
            .background(Color.aiBackground)
            .environmentObject(HomeCoordinator())
            .environmentObject(DIContainer().makeGoalViewModel())
    }
}
