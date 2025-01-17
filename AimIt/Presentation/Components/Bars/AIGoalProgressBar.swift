//
//  AIProgressBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AIGoalProgressBar: View {
    @State private var milestonesWidths: [CGFloat] = []
    @State private var animationProgress: [CGFloat] = []
    
    private let goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        if !goal.milestones.isEmpty {
            GeometryReader { geometry in
                HStack(spacing: 4) {
                    ForEach(goal.milestones.indices, id: \.self) { index in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.aiSecondary.gradient)
                                .frame(maxWidth: .infinity)
                                .frame(height: 20)
                            
                            Capsule()
                                .fill(Color.accentColor.gradient)
                                .frame(
                                    width: index < animationProgress.count ?
                                    animationProgress[index] * geometry.size.width / CGFloat(max(1, goal.milestones.count)) : 0,
                                    height: 20
                                )
                                .animation(
                                    index < animationProgress.count
                                    ? .easeInOut(duration: 1.5)
                                    : nil,
                                    value: index < animationProgress.count ? animationProgress[index] : 0
                                )
                        }
                    }
                }
                .onAppear(perform: animate)
            }
            .frame(height: 20)
        }
    }
    
    private func animate() {
        let totalMilestones = goal.milestones.count

        animationProgress = Array(repeating: 0, count: totalMilestones)
        
        for (index, milestone) in goal.milestones.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1.3) {
                if milestone.isCompleted {
                    withAnimation {
                        animationProgress[index] = 1.0
                    }
                }
            }
        }
    }
}

#Preview {
    AIGoalProgressBar(goal: .sample)
        .preferredColorScheme(.dark)
}
