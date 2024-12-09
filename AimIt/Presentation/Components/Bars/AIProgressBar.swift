//
//  AIProgressBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AIProgressBar: View {
    let goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var segmentCount: Int {
        goal.milestones.count
    }
    
    var body: some View {
        HStack(spacing: 10) {
            if goal.milestones.isEmpty {
                RoundedRectangle(cornerRadius: 15)
                    .fill(goal.isCompleted ? Color.aiOrange : Color.aiLabel)
                    .frame(maxWidth: .infinity, maxHeight: 20)
            } else {
                HStack(spacing: 4) {
                    ForEach(goal.milestones) { milestone in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(milestone.isCompleted ? Color.aiOrange : Color.aiLabel)
                            .frame(maxWidth: .infinity, maxHeight: 20)
                            .layoutPriority(1)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 20)
    }
}

#Preview {
    AIProgressBar(goal: .sample)
        .preferredColorScheme(.dark)
}
