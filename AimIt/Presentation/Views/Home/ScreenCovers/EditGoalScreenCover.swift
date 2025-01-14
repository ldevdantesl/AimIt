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
    
    @Binding private var goal: Goal
    
    init(goal: Binding<Goal>) {
        self._goal = goal
    }
    
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
                
                AIDateField(
                    titleName: "Select a Deadline",
                    widthSize: UIConstants.halfWidth,
                    chosenDate: $newDeadline
                )
                
                CreateMilestoneView(
                    goal: goal,
                    milestones: $newMilestones
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
            self.newTitle = goal.title
            self.newMilestones = goal.milestones
            self.newDesc = goal.desc ?? ""
            self.newDeadline = goal.deadline
        }
        .hideKeyboardOnTap()
    }
    
    private func editGoal() {
        if titleErrorMsg == nil {
            if let goal = goalVM.editGoal (
                goal,
                title: newTitle,
                desc: newDesc.isEmpty ? nil : newDesc,
                deadline: newDeadline,
                newMilestones: newMilestones
            ) { self.goal = goal }
            coordinator.dismissFullScreenCover()
        }
    }
}

#Preview {
    EditGoalScreenCover(goal: .constant(.sample))
        .environmentObject(HomeCoordinator())
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
