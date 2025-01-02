//
//  AIMilestonesList.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import SwiftUI

struct AIGoalMilestonesList: View {
    @EnvironmentObject var goalVM: GoalViewModel
    
    @State private var sortType: (Milestone, Milestone) -> Bool = { $0.isCompleted && !$1.isCompleted }
    
    var milestonesFiltered: [Milestone] {
        goalVM.selectedGoal.milestones.sorted(by: sortType)
    }
    
    var body: some View {
        if !goalVM.selectedGoal.milestones.isEmpty {
            LazyVStack(spacing: 20){
                HStack{
                    Text("Milestones")
                        .font(.system(.headline, design: .rounded, weight: .light))
                        .foregroundStyle(.aiSecondary2)
                    
                    Spacer()
                    
                    Menu {
                        Button("First Done") { sortType = { $0.isCompleted && !$1.isCompleted } }
                        Button("First Undone") { sortType = { !$0.isCompleted && $1.isCompleted } }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.aiLabel)
                    }
                }
                .padding(.horizontal, 20)
                ForEach(milestonesFiltered) { milestone in
                    AIMilestoneRow(milestone: milestone)
                }
            }
        }
    }
}

#Preview {
    AIGoalMilestonesList()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
