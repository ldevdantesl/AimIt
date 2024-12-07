//
//  AIProgressBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AIProgressBar: View {
    var milestones: [Milestone]
    
    init(milestones: [Milestone]) {
        self.milestones = milestones
    }
    
    var segmentCount: Int {
        milestones.isEmpty ? 1 : milestones.count
    }
    
    private let spacing: CGFloat = 4.0
    
    var body: some View {
        GeometryReader { geometry in
            let segmentWidth = (geometry.size.width - (CGFloat(segmentCount - 1) * spacing)) / CGFloat(segmentCount)
            let segmentHeight = geometry.size.height
            
            HStack(spacing: spacing) {
                if milestones.isEmpty {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: segmentWidth, height: segmentHeight)
                        .cornerRadius(14)
                } else {
                    ForEach(milestones) { milestone in
                        Rectangle()
                            .fill(milestone.isCompleted ? Color.green : Color.gray.opacity(0.5))
                            .frame(width: segmentWidth, height: segmentHeight)
                            .cornerRadius(14)
                    }
                }
            }
        }
        .frame(height: 20) // D
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIProgressBar(milestones: [])
}
