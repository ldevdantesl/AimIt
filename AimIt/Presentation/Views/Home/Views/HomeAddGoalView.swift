//
//  AddGoalView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct HomeAddGoalView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    
    @State private var titleErrorMsg: String? = ""
    
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var deadline: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State private var category: String = ""
    @State private var milestones: [Milestone] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                AIHeaderView(
                    rightButton: AIButton(
                        image: .xmark,
                        backColor: .aiSecondary,
                        foreColor: .aiLabel,
                        action: coordinator.goBack
                    ),
                    title: "New Goal",
                    subtitle: "For \(workspaceVM.currentWorkspace.title)"
                )
            
                AITextField(
                    titleName: "Title*",
                    placeholder: "Prepare for test ...",
                    text: $title,
                    errorMsg: $titleErrorMsg
                )
                
                AITextField(
                    titleName: "Description",
                    placeholder: "Prepare for first part and ...",
                    text: $desc,
                    errorMsg: .constant(nil),
                    validationOptions: [],
                    axis: .vertical
                )
                
                AIDateField(
                    titleName: "Deadline*",
                    widthSize: UIConstants.halfWidth,
                    chosenDate: $deadline
                )
                
                CreateMilestoneView (
                    goalTitle: title,
                    goalDeadline: deadline,
                    milestones: $milestones
                )
            }
            .padding(.vertical, 10)
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: "Create", color: userVM.themeColor, action: addGoal)
                    .disabled(titleErrorMsg != nil)
            }
        }
        .hideKeyboardOnTap()
    }
    
    private func addGoal() {
        if titleErrorMsg == nil {
            goalVM.addGoal(
                to: workspaceVM.currentWorkspace,
                title: title,
                desc: desc,
                deadline: deadline,
                milestones: milestones
            )
            coordinator.goBack()
        }
    }
}

#Preview {
    NavigationStack{
        HomeAddGoalView()
            .environmentObject(DIContainer().makeGoalViewModel())
            .environmentObject(HomeCoordinator())
            .environmentObject(DIContainer().makeWorkspaceViewModel())
    }
}
