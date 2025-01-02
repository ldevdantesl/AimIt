//
//  AIMilestoneList.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIMilestoneCreationList: View {
    @Binding var milestones: [Milestone]
    
    var body: some View {
        if milestones.isEmpty {
            NotFoundView(
                imageName: ImageNames.noMilestones,
                title: "No Milestones",
                topPadding: 40,
                subtitle: "Tap to add new milestone to you goal",
                action: {}
            )
        } else {
            LazyVStack(spacing: 12){
                ForEach(milestones, id: \.self) { milestone in
                    AIMilestoneRow(milestone: milestone, onDelete: { onDelete(milestone: milestone) })
                }
            }
            .animation(.bouncy, value: milestones)
        }
    }
    
    func onDelete(milestone: Milestone) {
        milestones.removeAll { $0.id == milestone.id }
    }
}

#Preview {
    AIMilestoneCreationList(milestones: .constant(Milestone.sampleMilestones))
        .background(Color.aiBackground)
}
