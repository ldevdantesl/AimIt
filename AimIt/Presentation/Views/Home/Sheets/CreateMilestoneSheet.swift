//
//  AddMilestoneView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct CreateMilestoneSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var titleErrorMsg: String? = ""
    @State private var systemImage: String = "folder"
    @State private var dueDate: Date? = nil
    
    @Binding var milestones: [Milestone]
    let goalTitle: String
    
    init(goalTitle: String, milestones: Binding<[Milestone]>) {
        self.goalTitle = goalTitle
        self._milestones = milestones
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 20){
                    AIHeaderView(
                        rightButton: AIButton(
                            image: .xmark,
                            backColor: Color.accentColor,
                            foreColor: Color.aiLabel,
                            action: { dismiss() }
                        ),
                        title: "Add Milestone",
                        subtitle: "For: \(goalTitle)"
                    )
                    
                    AITextField(
                        titleName: "Title",
                        placeholder: "Get ready for ...",
                        text: $title,
                        errorMsg: $titleErrorMsg
                    )
                    
                    AIOptionalDatePicker(
                        titleName: "Due to: (optional)",
                        widthSize: UIConstants.screenWidth,
                        chosenDate: $dueDate
                    )
                    
                    AISystemImagePicker(selectedImage: $systemImage)
                    
                    Spacer(minLength: 60)
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        AIButton(title: "Create") {
                            milestones.append(
                                Milestone(
                                    id: UUID(),
                                    desc: title,
                                    systemImage: systemImage,
                                    dueDate: dueDate,
                                    isCompleted: false,
                                    goalID: UUID()
                                )
                            )
                            dismiss()
                        }
                        .disabled(titleErrorMsg != nil)
                    }
                }
                .padding(.top, 10)
            }
            .background(Color.aiBackground)
            .toolbarBackground(Color.black, for: .bottomBar)
        }
    }
}

#Preview {
    NavigationStack {
        CreateMilestoneSheet(goalTitle: "Some shitty stuff", milestones: .constant([]))
            .background(Color.aiBackground)
            .environmentObject(DIContainer().makeMilestoneViewModel())
            .environmentObject(HomeCoordinator())
    }
    .scrollContentBackground(.hidden)
}
