//
//  AIDateField.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.01.2025.
//

import SwiftUI

struct AIDateCard: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    
    @Binding var goal: Goal
    
    init(goal: Binding<Goal>) {
        self._goal = goal
    }
    
    private var isDayPassed: Bool {
        DeadlineFormatter.isDayPassed(goal.deadline)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            Text("Deadline: \(DeadlineFormatter.formatToDayMonth(goal.deadline))")
                .font(.system(.subheadline, design: .rounded, weight: .light))
                .foregroundColor(.aiSecondary2)
                .padding(.bottom, 3)
            
            HStack{
                Text("\(DeadlineFormatter.formatToDaysLeftDescription(goal.deadline))")
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiLabel)
                
                Spacer()
                
                Image(.clock)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text("\(daysGone)/\(totalDays) day(s)")
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiSecondary2)
            }
            .padding(.bottom, 15)
            
            AITimeProgressBar(
                createdDate: goal.createdAt,
                dueDate: goal.deadline,
                datePassedAction: coordinateToEditDate
            )
            .padding(.bottom, 10)
            
            AIFooterNote(text: "If deadline is passed you won't be able to manipulate the goal unless you change the deadline. Tap to change it",
                         condition: isDayPassed)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
    private func coordinateToEditDate() {
        coordinator.present(sheet: .changeDeadline($goal))
    }
    
    private var totalDays: Int {
        // Calculate total number of days between creation and due date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: goal.createdAt, to: goal.deadline)
        return max(components.day ?? 0, 1) // Ensure it's non-negative
    }
    
    private var daysGone: Int {
        // Calculate how many days have passed since the creation date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: goal.createdAt, to: Date())
        return max(components.day ?? 0, 1) // Ensure it's non-negative
    }
    
}

#Preview {
    AIDateCard(goal: .constant(.sample))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(HomeCoordinator())
}
