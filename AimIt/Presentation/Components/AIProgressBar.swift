//
//  AIProgressBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AIProgressBar: View {
    let goal: Goal?
    
    let initialMilestones: [Milestone]?
    
    init(goal: Goal) {
        self.goal = goal
        self.initialMilestones = nil
    }
    
    init(initialMilestones: [Milestone]){
        self.goal = nil
        self.initialMilestones = initialMilestones
    }
    
    var segmentCount: Int {
        goal == nil ? initialMilestones?.count ?? 1 : goal?.milestones.count ?? 1
    }
    
    var milestones: [Milestone] {
        goal == nil ? initialMilestones ?? [] : goal?.milestones ?? []
    }
    
    var sortedMilestones: [Milestone] {
        milestones.sorted { $0.isCompleted && !$1.isCompleted }
    }
    
    private let spacing: CGFloat = 4.0
    
    var body: some View {
        GeometryReader { geometry in
            let segmentWidth = (geometry.size.width - (CGFloat(segmentCount - 1) * spacing)) / CGFloat(segmentCount)
            let segmentHeight = geometry.size.height
            
            HStack(spacing: spacing) {
                if milestones.isEmpty {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(goal?.isCompleted ?? false ? Color.green : Color.aiLightPink)
                        .frame(width: segmentWidth, height: segmentHeight)
                } else {
                    ForEach(sortedMilestones) { milestone in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(milestone.isCompleted ? Color.green : Color.aiLightPink)
                            .frame(width: segmentWidth, height: segmentHeight)
                    }
                }
            }
        }
        .frame(height: 20) // D
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIProgressBar(goal: .sample)
}
