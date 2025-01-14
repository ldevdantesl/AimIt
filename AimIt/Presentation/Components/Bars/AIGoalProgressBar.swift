//
//  AIProgressBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AIGoalProgressBar: View {
    private let goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    @State private var progressWidth: CGFloat = 0.0
    
    var body: some View {
        if !goal.milestones.isEmpty{
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.aiSecondary)
                        .frame(height: 20)
                    
                    Capsule()
                        .fill(Color.accentColor)
                        .frame(width: max(0, progressWidth)) // Ensure valid width
                        .frame(height: 20)
                        .animation(.easeInOut(duration: 1.0), value: progressWidth)
                }
                .onAppear {
                    // Calculate total progress based on completed milestones
                    let totalMilestones = CGFloat(goal.milestones.count)
                    let completedMilestones = CGFloat(goal.milestones.filter { $0.isCompleted }.count)
                    let progressFraction = totalMilestones > 0 ? completedMilestones / totalMilestones : 0.0
                    
                    // Safeguard progressFraction within [0, 1]
                    let clampedProgressFraction = max(0, min(1, progressFraction))
                    
                    // Use GeometryReader to get the available width
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            self.progressWidth = geometry.size.width * clampedProgressFraction
                        }
                    }
                }
            }
            .frame(height: 20)
        }
    }
}

#Preview {
    AIGoalProgressBar(goal: .sample)
        .preferredColorScheme(.dark)
}
