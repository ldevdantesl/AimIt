//
//  AddMilestoneView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct HomeCreateMilestoneView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var systemImage: String = "folder"

    @Binding var milestones: [Milestone]
    let goalTitle: String
    
    init(goalTitle: String, milestones: Binding<[Milestone]>) {
        self.goalTitle = goalTitle
        self._milestones = milestones
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20){
                    AIHeaderView(
                        rightButton: AIButton(
                            image: .xmark,
                            backColor: Color.accentColor,
                            foreColor: Color.aiLabel,
                            action: {
                                dismiss()
                            }
                        ),
                        title: "For \(goalTitle)",
                        subtitle: "Add Milestone"
                    )
                    
                    AITextField(titleName: "Title", placeholder: "Get ready for ...", text: $title)
                    
                    Spacer()
                        .frame(height: 10)
                    
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
                                    isCompleted: false,
                                    goalID: UUID()
                                )
                            )
                            dismiss()
                        }
                    }
                }
                .padding(.top, 10)
            }
            .background(Color.aiBackground)
        }
    }
}

#Preview {
    NavigationStack{
        HomeCreateMilestoneView(goalTitle: "Some shitty stuf likejri sdjfif jisod jfio", milestones: .constant([]))
            .background(Color.aiBackground)
            .environmentObject(DIContainer().makeMilestoneViewModel())
    }
}
