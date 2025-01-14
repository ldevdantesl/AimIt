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
    @Binding private var chosenDate: Date

    init(chosenDate: Binding<Date>) {
        self._chosenDate = chosenDate
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
                dismiss()
            }
        }
        .background(Color.aiBackground)
    }
}

#Preview {
    AIDatePicker(chosenDate: .constant(.now))
}
