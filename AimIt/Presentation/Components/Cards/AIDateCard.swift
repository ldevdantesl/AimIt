//
//  AIDateField.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.01.2025.
//

import SwiftUI

struct AIDateCard: View {
    private let createdDate: Date
    private let date: Date
    
    init(createdDate: Date, date: Date) {
        self.createdDate = createdDate
        self.date = date
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Deadline: \(DeadlineFormatter.formatToDayMonth(date))")
                .font(.system(.subheadline, design: .rounded, weight: .light))
                .foregroundColor(.aiSecondary2)
                .padding(.bottom, 3)
            HStack{
                Text("\(DeadlineFormatter.formatToDaysLeft(date))")
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiSecondary2)
                
                Spacer()
                
                Image(.clock)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text("\(daysGone)/\(totalDays)")
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiSecondary2)
            }
            .padding(.bottom, 15)
            
            AITimeProgressBar(createdDate: createdDate, dueDate: date)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
    private var totalDays: Int {
        // Calculate total number of days between creation and due date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: createdDate, to: date)
        return max(components.day ?? 0, 1) // Ensure it's non-negative
    }
    
    private var daysGone: Int {
        // Calculate how many days have passed since the creation date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: createdDate, to: Date())
        return max(components.day ?? 0, 1) // Ensure it's non-negative
    }
    
}

#Preview {
    AIDateCard(createdDate: .now, date: .now)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
