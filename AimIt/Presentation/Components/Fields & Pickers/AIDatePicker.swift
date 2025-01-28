//
//  AIDatePicker.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.01.2025.
//

import Foundation
import SwiftUI

struct AIDatePicker: View {
    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var goalVM: GoalViewModel
    @Binding private var chosenDate: Date
    
    private let goal: Goal?
    
    private let lowerBound = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    init(chosenDate: Binding<Date>, for goal: Goal? = nil) {
        self._chosenDate = chosenDate
        self.goal = goal
    }
    
    var body: some View {
        VStack{
            DatePicker(
                "",
                selection: $chosenDate,
                in: lowerBound...,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding(.horizontal, 20)
            
            AIButton(title: "Done", color: userVM.themeColor){
                if let goal = goal {
                    goalVM.editGoal(goal, deadline: chosenDate)
                }
                dismiss()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .onDisappear {
            if let goal = goal {
                goalVM.editGoal(goal, deadline: chosenDate)
            }
        }
    }
}

#Preview {
    AIDatePicker(chosenDate: .constant(.now), for: .sample)
}
