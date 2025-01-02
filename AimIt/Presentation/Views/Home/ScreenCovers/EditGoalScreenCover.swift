//
//  EditGoalView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 27.12.2024.
//

import SwiftUI

struct EditGoalScreenCover: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    
    @State private var titleErrorMsg: String?
    
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
                    action: coordinator.dismissFullScreenCover
                ),
                title: "Edit goal",
                subtitle: newTitle
            )
            
            Spacer(minLength: 20)
            
            VStack(spacing: 20){
                AITextField(
                    titleName: "Title*",
                    placeholder: "Prepare to ...",
                    text: $newTitle,
                    errorMsg: $titleErrorMsg
                )
                
                AITextField(
                    titleName: "Description(optional)",
                    placeholder: "Do not forget about...",
                    text: $newDesc,
                    errorMsg: .constant(nil),
                    validationOptions: [],
                    axis: .vertical,
                    submitLabel: .next
                )
                
                AIDatePicker(
                    titleName: "Select a Deadline",
                    widthSize: UIConstants.halfWidth,
                    chosenDate: $newDeadline
                )
                
                CreateMilestoneView(
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
                AIButton(
                    title: "Save",
                    action: editGoal
                )
                .disabled(titleErrorMsg != nil)
            }
        }
        .onAppear {
            self.newTitle = goalVM.selectedGoal.title
            self.newMilestones = goalVM.selectedGoal.milestones
            self.newDesc = goalVM.selectedGoal.desc ?? ""
            self.newDeadline = goalVM.selectedGoal.deadline
        }
        .hideKeyboardOnTap()
    }
    
    private func editGoal() {
        if titleErrorMsg == nil {
            goalVM.editGoal (
                goalVM.selectedGoal,
                title: newTitle,
                desc: newDesc.isEmpty ? nil : newDesc,
                deadline: newDeadline,
                newMilestones: newMilestones
            )
            coordinator.dismissFullScreenCover()
        }
    }
}

#Preview {
    EditGoalScreenCover()
        .environmentObject(HomeCoordinator())
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
