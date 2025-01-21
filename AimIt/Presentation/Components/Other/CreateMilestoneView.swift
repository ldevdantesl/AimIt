//
//  AIAddMilestoneFild.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct CreateMilestoneView: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @Binding var milestones: [Milestone]
    @State private var onSheet: Bool = false
    
    private let goal: Goal?
    private let goalTitle: String
    private let goalDeadline: Date
        
    /// Default Initializer for updating existing goal
    init(goal: Goal, milestones: Binding<[Milestone]>) {
        self.goal = goal
        self._milestones = milestones
        self.goalTitle = goal.title
        self.goalDeadline = goal.deadline
    }
    
    /// Initializer for creating new milestone for new goal.
    init(goalTitle: String, goalDeadline: Date, milestones: Binding<[Milestone]>) {
        self._milestones = milestones
        self.goalTitle = goalTitle
        self.goal = nil
        self.goalDeadline = goalDeadline
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Text("Milestones")
                    .font(.system(.headline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                Spacer()
                
                AIButton(
                    image: .plus,
                    backColor: .accentColor,
                    foreColor: .aiLabel,
                    action: { onSheet.toggle() }
                )
            }
            .padding(.horizontal, 20)
            Divider()
                .background(Color.aiLabel)
                .padding(.vertical, 10)
            
            AIMilestoneCreationList(
                milestones: $milestones,
                createMilestoneSheet: $onSheet
            )
        }
        .sheet(isPresented: $onSheet) {
            if let goal = goal {
                CreateMilestoneSheet (
                    goal: goal,
                    milestones: $milestones
                )
            } else {
                CreateMilestoneSheet (
                    goalTitle: goalTitle,
                    goalDeadline: goalDeadline,
                    milestones: $milestones
                )
            }
        }
    }
}

#Preview {
    CreateMilestoneView(goal: .sample, milestones: .constant(Milestone.sampleMilestones))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(HomeCoordinator())
}
