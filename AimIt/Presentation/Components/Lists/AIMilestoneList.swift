//
//  AIMilestoneList.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIMilestoneList: View {
    @Binding var milestones: [Milestone]
    
    var body: some View {
        LazyVStack(spacing: 12){
            ForEach(milestones, id: \.self) { milestone in
                AIMilestoneRow(milestone: milestone, onDelete: onDelete)
            }
        }
        .animation(.bouncy, value: milestones)
    }
    
    func onDelete(milestone: Milestone) {
        milestones.removeAll { $0.id == milestone.id }
    }
}

#Preview {
    AIMilestoneList(milestones: .constant(Milestone.sampleMilestones))
        .background(Color.aiBackground)
}
