//
//  GoalDetailsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

struct GoalDetailsView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    @Binding private var goal: Goal
    
    init(goal: Binding<Goal>) {
        self._goal = goal
    }
    
    private var isDeadlinePassed: Bool {
        DeadlineFormatter.isDayPassed(goal.deadline)
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
                    backColor: isDeadlinePassed ? .aiSecondary : userVM.themeColor,
                    foreColor: isDeadlinePassed ? .aiSecondary2 : .aiLabel,
                    action: coordinateToEditGoal
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
            
            AIDateCard(goal: $goal)
            
            Spacer(minLength: 30)
            
            if goal.milestones.isEmpty {
                NotFoundView(
                    imageName: isDeadlinePassed ? ImageNames.deadlinePassed : ImageNames.noMilestones,
                    title: "Oops...",
                    subtitle: isDeadlinePassed ? "The Deadline is passed " : "No milestones, tap to add.",
                    action: isDeadlinePassed ? coordinateToChangeDeadline : coordinateToEditGoal
                )
            } else {
                AIGoalMilestonesList(
                    goalMilestones: $goal.milestones,
                    isTogglingEnabled: !isDeadlinePassed
                )
                .padding(.bottom, 20)
                .overlay {
                    if isDeadlinePassed{
                        NotFoundView(
                            imageName: ImageNames.deadlinePassed,
                            title: "Deadline Passed",
                            subtitle: "",
                            action: coordinateToChangeDeadline
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.all, 20)
                    }
                }
            }
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton (
                    title: goal.isCompleted ? "Uncomplete" : "Complete",
                    color: !isCompleteDisabled ? .secondary : userVM.themeColor,
                    action: toggleCompletion
                )
                .disabled(!isCompleteDisabled)
            }
        }
    }
    
    private func toggleCompletion() {
        DispatchQueue.main.async {
            goal.isCompleted ? goalVM.uncompleteGoal(goal) : goalVM.completeGoal(goal)
            goal.isCompleted.toggle()
            goal.completedAt = goal.isCompleted ? Date() : nil
            coordinator.goBack()
        }
    }
    
    private func coordinateToEditGoal() {
        coordinator.present(fullScreenCover: .editGoal($goal))
    }
    
    private var isCompleteDisabled: Bool {
        return goal.milestones.allSatisfy { $0.isCompleted } && !DeadlineFormatter.isDayPassed(goal.deadline)
    }
    
    private func coordinateToChangeDeadline() {
        coordinator.present(sheet: .changeDeadline($goal))
    }
}

#Preview {
    NavigationStack{
        GoalDetailsView(goal: .constant(.sample))
            .background(Color.aiBackground)
            .environmentObject(HomeCoordinator())
            .environmentObject(DIContainer().makeGoalViewModel())
            .environmentObject(DIContainer().makeWorkspaceViewModel())
    }
}
