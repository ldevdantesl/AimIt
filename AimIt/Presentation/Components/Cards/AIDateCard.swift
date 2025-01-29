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
                .contentTransition(.numericText())
            
            HStack{
                Text("\(DeadlineFormatter.formatToDaysLeftDescription(goal.deadline))")
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiLabel)
                    .contentTransition(.numericText())
                
                Spacer()
                
                Image(ImageNames.clock)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text("\(daysGone)/\(totalDays) day(s)")
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiSecondary2)
                    .contentTransition(.numericText())
            }
            .padding(.bottom, 15)
            
            AITimeProgressBar(
                createdDate: goal.createdAt,
                dueDate: goal.deadline,
                datePassedAction: coordinateToEditDate
            )
            .padding(.bottom, 10)
            .id(goal.deadline)
            
            AIFooterNote(
                text: "If deadline is passed you can't manipulate the goal unless you change the deadline. Tap to change it",
                condition: isDayPassed
            )
            .onTapGesture(perform: coordinateToEditDate)
            .contentTransition(.numericText())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
    private func coordinateToEditDate() {
        coordinator.present(sheet: .changeDeadline($goal))
    }
    
    private var totalDays: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: goal.createdAt, to: goal.deadline)
        return max(components.day ?? 0, 1)
    }
    
    private var daysGone: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: goal.createdAt, to: Date())
        return max(components.day ?? 0, 1)
    }
    
}

#Preview {
    AIDateCard(goal: .constant(.sample))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(HomeCoordinator())
}
