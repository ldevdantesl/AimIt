//
//  AIDatePicker.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.01.2025.
//

import Foundation
import SwiftUI

struct AIDatePicker: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var goalVM: GoalViewModel
    @Binding private var chosenDate: Date
    
    private let goal: Goal?
    
    init(chosenDate: Binding<Date>, for goal: Goal? = nil) {
        self._chosenDate = chosenDate
        self.goal = goal
    }
    
    var body: some View {
        VStack{
            DatePicker(
                "",
                selection: $chosenDate,
                in: Calendar.current.date(byAdding: .day, value: 1, to: Date())!...,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding(.horizontal, 20)
            
            AIButton(title: "Done"){
                if let goal = goal {
                    goalVM.editGoal(goal, deadline: chosenDate)
                }
                dismiss()
            }
        }
        .background(Color.aiBackground)
    }
}

#Preview {
    AIDatePicker(chosenDate: .constant(.now), for: .sample)
}
