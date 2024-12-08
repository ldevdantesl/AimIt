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
    let showingPercentage: Bool
    
    init(goal: Goal, showingPercentage: Bool = false) {
        self.goal = goal
        self.initialMilestones = nil
        self.showingPercentage = showingPercentage
    }
    
    init(initialMilestones: [Milestone], showingPercentage: Bool = false){
        self.goal = nil
        self.initialMilestones = initialMilestones
        self.showingPercentage = showingPercentage
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
    
    var percentage: Double {
        sortedMilestones.reduce(0) { $0 + ($1.isCompleted ? 1 : 0) } / Double(segmentCount)
    }
    
    var percentageDesc: String {
        String((percentage * 100).description.prefix(4))
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if showingPercentage {
                Text("\( milestones.isEmpty ? "0" : percentageDesc)%")
                    .foregroundStyle(.aiLabel)
                    .frame(maxWidth: 50, alignment: .leading)
            }
            
            if milestones.isEmpty {
                RoundedRectangle(cornerRadius: 15)
                    .fill(goal?.isCompleted ?? false ? Color.green : Color.aiLabel)
                    .frame(maxWidth: .infinity, maxHeight: 20)
            } else {
                HStack(spacing: 4) {
                    ForEach(milestones) { milestone in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(milestone.isCompleted ? Color.green : Color.aiLabel)
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
    AIProgressBar(initialMilestones: [], showingPercentage: true)
        .preferredColorScheme(.dark)
}
