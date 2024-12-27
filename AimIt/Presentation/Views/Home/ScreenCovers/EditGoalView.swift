//
//  EditGoalView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 27.12.2024.
//

import SwiftUI

struct EditGoalView: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    
    @State private var goal: Goal = .sample
    
    @State private var newDesc: String = ""
    @State private var newMilestones: [Milestone] = []
    
    var body: some View {
        ScrollView{
            AIHeaderView(
                rightButton: AIButton(
                    image: .xmark,
                    backColor: .aiOrange,
                    foreColor: .aiLabel,
                    action: coordinator.dismiss
                ),
                title: "Edit goal",
                subtitle: goal.title
            )
            
            Spacer(minLength: 20)
            
            VStack(spacing: 20){
                AITextField(
                    titleName: "Title*",
                    placeholder: "Prepare to ...",
                    text: $goal.title
                )
                
                AITextField(
                    titleName: "Description(optional)",
                    placeholder: "Do not forget about...",
                    text: $newDesc,
                    axis: .vertical
                )
                
                AIDatePicker(
                    titleName: "Select a Deadline",
                    widthSize: UIConstants.halfWidth,
                    chosenDate: $goal.deadline
                )
                
                AIAddMilestoneView(
                    milestones: $newMilestones,
                    goalTitle: goal.title
                )
                
                Spacer(minLength: 20)
            }
        }
        .scrollIndicators(.hidden)
        .background(Color.aiBackground)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: "Save") {
                    goalVM.editGoals (
                        goal,
                        title: goal.title,
                        desc: newDesc.isEmpty ? nil : newDesc,
                        deadline: goal.deadline
                    )
                    saveGoal()
                }
            }
        }
        .onAppear {
            self.goal = goalVM.selectedGoal
            self.newMilestones = goal.milestones
            goal.milestones.forEach { milestoneVM.deleteMilestone($0) }
            self.newDesc = goal.desc ?? ""
        }
    }
    
    private func saveGoal() {
        newMilestones.forEach {
            milestoneVM.addMilestone(
                desc: $0.desc,
                systemImage: $0.systemImage,
                completed: $0.isCompleted,
                to: goal
            )
        }
        goal.milestones = newMilestones
        goal.desc = newDesc
        goalVM.selectedGoal = goal
        coordinator.dismiss()
    }
}

#Preview {
    EditGoalView()
        .environmentObject(HomeCoordinator())
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
