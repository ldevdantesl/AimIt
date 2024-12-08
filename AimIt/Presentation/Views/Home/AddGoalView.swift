//
//  AddGoalView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AddGoalView: View {
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var chosenDate: Date = .now
    @State private var category: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30){
                AIHeaderView(
                    leftButton: AIButton(image: .back, action: coordinator.goBack),
                    rightButton: AIButton(image: .ellipsis),
                    title: "New Goal"
                )
            
                AITextField(
                    titleName: "Title*",
                    placeholder: "Prepare for test",
                    text: $title
                )
                
                AITextField(
                    titleName: "Description",
                    placeholder: "Prepare for first part and ...",
                    text: $desc,
                    axis: .vertical
                )
                
                HStack{
                    AIDatePicker(
                        titleName: "Due Date*",
                        widthSize: UIConstants.halfWidth,
                        chosenDate: $chosenDate
                    )
                    
                    AITextField(
                        titleName: "Category",
                        placeholder: "Sport",
                        text: $category,
                        width: UIConstants.halfWidth
                    )
                }
            }
            .padding(.top, 10)
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    AddGoalView()
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(DIContainer().makeAppCoordinator().makeHomeCoordinator())
}
