//
//  AIMilestonesList.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import SwiftUI

struct AIGoalMilestonesList: View {
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    
    @State private var sortType: (Milestone, Milestone) -> Bool = { $0.isCompleted && !$1.isCompleted }
    
    @Binding private var goalMilestones: [Milestone]
    
    init(goalMilestones: Binding<[Milestone]>) {
        self._goalMilestones = goalMilestones
    }
    
    var body: some View {
        LazyVStack(spacing: 20){
            HStack{
                Text("Milestones")
                    .font(.system(.headline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                
                Spacer()
                
                Menu {
                    Text("Sort By")
                    Button("First Done") {
                        sortType = { $0.isCompleted && !$1.isCompleted }
                        goalMilestones.sort(by: sortType)
                    }
                    Button("First Undone") {
                        sortType = { !$0.isCompleted && $1.isCompleted }
                        goalMilestones.sort(by: sortType)
                    }
                    Button("Deadline") {
                        sortType = {
                            if let firstDate = $0.dueDate, let secondDate = $1.dueDate {
                                return firstDate < secondDate
                            } else if $0.dueDate == nil && $1.dueDate == nil {
                                return false
                            } else {
                                return $0.dueDate == nil
                            }
                        }
                        goalMilestones.sort(by: sortType)
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.aiLabel)
                }
            }
            .padding(.horizontal, 20)
            ForEach($goalMilestones) { milestone in
                AIMilestoneRow(
                    milestone: milestone,
                    onTap: onMilestoneTap
                )
            }
        }
    }
    
    private func onMilestoneTap(milestone: Binding<Milestone>) {
        coordinator.present(sheet: .milestoneDetails(milestone))
    }
}

#Preview {
    AIGoalMilestonesList(goalMilestones: .constant(Milestone.sampleMilestones))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(HomeCoordinator())
}
