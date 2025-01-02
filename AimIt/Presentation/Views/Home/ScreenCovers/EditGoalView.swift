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
    
    @State private var newTitle: String = ""
    @State private var newDesc: String = ""
    @State private var newMilestones: [Milestone] = []
    @State private var newDeadline: Date = .now
    
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
                subtitle: newTitle
            )
            
            Spacer(minLength: 20)
            
            VStack(spacing: 20){
                AITextField(
                    titleName: "Title*",
                    placeholder: "Prepare to ...",
                    text: $newTitle
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
                    chosenDate: $newDeadline
                )
                
                AIAddMilestoneView(
                    milestones: $newMilestones,
                    goalTitle: goalVM.selectedGoal.title
                )
                
                Spacer(minLength: 20)
            }
        }
        .scrollIndicators(.hidden)
        .background(Color.aiBackground)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: "Save") {
                    goalVM.editGoal (
                        goalVM.selectedGoal,
                        title: newTitle,
                        desc: newDesc.isEmpty ? nil : newDesc,
                        deadline: newDeadline,
                        newMilestones: newMilestones
                    )
                    coordinator.dismiss()
                }
            }
        }
        .onAppear {
            self.newTitle = goalVM.selectedGoal.title
            self.newMilestones = goalVM.selectedGoal.milestones
            self.newDesc = goalVM.selectedGoal.desc ?? ""
            self.newDeadline = goalVM.selectedGoal.deadline
        }
    }
}

#Preview {
    EditGoalView()
        .environmentObject(HomeCoordinator())
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
