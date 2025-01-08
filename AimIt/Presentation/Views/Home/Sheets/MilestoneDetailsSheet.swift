//
//  MilestoneDetailsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.01.2025.
//

import SwiftUI

struct MilestoneDetailsSheet: View {
    @EnvironmentObject var goalVM: GoalViewModel
    private let milestone: Milestone
    
    init(milestone: Milestone) {
        self.milestone = milestone
    }
    
    var body: some View {
        ZStack{
            VStack{
                AIInfoField(
                    title: "Description",
                    info: milestone.desc
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.aiBackground)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    AIButton(title: "Complete")
                }
            }
            .toolbarBackground(Color.aiBackground, for: .bottomBar)
        }
    }
}

#Preview {
    MilestoneDetailsSheet(milestone: .sample)
        .environmentObject(DIContainer().makeGoalViewModel())
}
