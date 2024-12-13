//
//  AddGoalView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AddGoalView: View {
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var deadline: Date = .now
    @State private var category: String = ""
    @State private var milestones: [Milestone] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                AIHeaderView(
                    leftButton: AIButton(image: .back, action: coordinator.goBack),
                    rightButton: AIButton(image: .ellipsis),
                    title: "New Goal",
                    subtitle: "For \(workspaceVM.currentWorkspace?.title ?? "Workspace")"
                )
            
                AITextField(
                    titleName: "Title*",
                    placeholder: "Example: Prepare for test ...",
                    text: $title
                )
                
                AITextField(
                    titleName: "Description",
                    placeholder: "Example: Prepare for first part and ...",
                    text: $desc,
                    axis: .vertical
                )
                
                HStack {
                    AIDatePicker(
                        titleName: "Due Date*",
                        widthSize: UIConstants.halfWidth,
                        chosenDate: $deadline
                    )
                    
                    AITextField(
                        titleName: "Category",
                        placeholder: "Example: Study",
                        text: $category,
                        width: UIConstants.halfWidth
                    )
                }
                
                AIAddMilestoneView(goalTitle: title, milestones: $milestones)
            }
            .padding(.vertical, 10)
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: "Create") {
                    coordinator.goBack()
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        AddGoalView()
            .environmentObject(DIContainer().makeGoalViewModel())
            .environmentObject(HomeCoordinator())
            .environmentObject(DIContainer().makeWorkspaceViewModel())
    }
}
