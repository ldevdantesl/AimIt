//
//  AddMilestoneView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AddMilestoneView: View {
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    let goal: Goal
    @State private var title: String = ""
    @State private var systemImage: String = "folder"
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                AIHeaderView(
                    rightButton: AIButton(
                        image: .xmark,
                        backColor: Color.accentColor,
                        foreColor: Color.aiLabel
                    ),
                    title: "For \(goal.title)",
                    subtitle: "Add Milestone"
                )
                
                AITextField(titleName: "Title", placeholder: "Get ready for ...", text: $title)
                
                Spacer()
                    .frame(height: 10)
                
                AISystemImagePicker(selectedImage: $systemImage)
                
                Spacer(minLength: 60)
            }
            .safeAreaInset(edge: .bottom) {
                AIButton(title: "Create") {
                    milestoneVM.addMilestone(desc: title, systemImage: systemImage, to: goal)
                }
            }
        }
        .background(Color.aiBackground)
    }
}

#Preview {
    AddMilestoneView(goal: .sample)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
