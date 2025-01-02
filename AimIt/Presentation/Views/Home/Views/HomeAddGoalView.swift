//
//  AddGoalView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct HomeAddGoalView: View {
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var deadline: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State private var category: String = ""
    @State private var milestones: [Milestone] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                AIHeaderView(
                    leftButton: AIButton(image: .back, action: coordinator.goBack),
                    rightButton: AIButton(image: .ellipsis),
                    title: "New Goal",
                    subtitle: "For \(workspaceVM.currentWorkspace.title)"
                )
            
                AITextField(
                    titleName: "Title*",
                    placeholder: "Prepare for test ...",
                    text: $title
                )
                
                AITextField(
                    titleName: "Description",
                    placeholder: "Prepare for first part and ...",
                    text: $desc,
                    axis: .vertical
                )
                
                AIDatePicker(
                    titleName: "Deadline*",
                    widthSize: UIConstants.halfWidth,
                    chosenDate: $deadline
                )
                
                AIAddMilestoneView(milestones: $milestones, goalTitle: title)
            }
            .padding(.vertical, 10)
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: "Create") {
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
