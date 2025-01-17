//
//  AddMilestoneView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct CreateMilestoneSheet: View {
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var titleErrorMsg: String? = ""
    @State private var systemImage: String = "folder"
    @State private var dueDate: Date? = nil
    
    @Binding var milestones: [Milestone]
    private let goal: Goal?
    private let goalTitle: String
    private let goalDeadline: Date
    
    ///Default initializer used for creating milestone for existing goal
    init(goal: Goal, milestones: Binding<[Milestone]>) {
        self.goal = goal
        self._milestones = milestones
        self.goalTitle = goal.title
        self.goalDeadline = goal.deadline
    }
    
    ///Default initializer used for creating milestone for existing goal
    init(goalTitle: String, goalDeadline: Date, milestones: Binding<[Milestone]>) {
        self.goalTitle = goalTitle
        self.goalDeadline = goalDeadline
        self._milestones = milestones
        self.goal = nil
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
                    
                    AIOptionalDateField(
                        titleName: "Due to: (optional)",
                        widthSize: UIConstants.screenWidth,
                        chosenDate: $dueDate,
                        dateUntil: deadline
                    )
                    
                    AISystemImagePicker(selectedImage: $systemImage)
                    
                    Spacer(minLength: 60)
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        AIButton(title: "Create") {
                            if let milestone = milestoneVM.createSeperateMilestone(
                                desc: title,
                                systemImage: systemImage,
                                dueDate: dueDate
                            ) {
                                milestones.append(milestone)
                            }
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
    
    private var deadline: Date? {
        if Calendar.current.isDateInToday(goalDeadline) {
            return nil
        } else if DeadlineFormatter.isDayPassed(goalDeadline) {
            return nil
        } else {
            return goalDeadline
        }
    }
}

#Preview {
    NavigationStack {
        CreateMilestoneSheet(goal:.sample, milestones: .constant([]))
            .background(Color.aiBackground)
            .environmentObject(DIContainer().makeMilestoneViewModel())
            .environmentObject(HomeCoordinator())
    }
    .scrollContentBackground(.hidden)
}
