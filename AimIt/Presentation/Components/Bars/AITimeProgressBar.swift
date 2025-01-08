//
//  AITimeProgressBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.01.2025.
//

import SwiftUI

struct AITimeProgressBar: View {
    private var createdDate: Date
    private var dueDate: Date
    
    init(createdDate: Date, dueDate: Date) {
        self.createdDate = createdDate
        self.dueDate = dueDate
    }
    
    var body: some View {
        HStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.accentColor)
                .frame(width: progressWidth, height: 20)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.aiSecondary)
                .frame(height: 20)
        }
    }
    // MARK: - Calculations
    private var totalDays: Int {
        // Calculate total number of days between creation and due date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: createdDate, to: dueDate)
        return max(components.day ?? 0, 1) // Ensure at least 1 day
    }
    
    private var daysGone: Int {
        // Calculate how many days have passed since the creation date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: createdDate, to: Date())
        return min(max(components.day ?? 0, 1), totalDays) // Clamp between 0 and totalDays
    }
    
    private var progressWidth: CGFloat {
        // Calculate the width of the filled portion of the bar
        let screenWidth = UIConstants.screenWidth - 40 // 20 padding on each side
        return screenWidth * CGFloat(daysGone) / CGFloat(totalDays)
    }
}

#Preview {
    AITimeProgressBar(createdDate: .now, dueDate: .now + 100)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
