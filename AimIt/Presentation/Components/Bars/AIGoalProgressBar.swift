//
//  AIProgressBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AIGoalProgressBar: View {
    let goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var segmentCount: Int {
        goal.milestones.count
    }
    
    var body: some View {
        if !goal.milestones.isEmpty {
            HStack(spacing: 4) {
                ForEach(goal.milestones) { milestone in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(milestone.isCompleted ? Color.accentColor : Color.ailIghtPink)
                        .frame(maxWidth: .infinity, maxHeight: 20)
                        .layoutPriority(1)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 20)
        }
    }
}

#Preview {
    AIGoalProgressBar(goal: .sample)
        .preferredColorScheme(.dark)
}
