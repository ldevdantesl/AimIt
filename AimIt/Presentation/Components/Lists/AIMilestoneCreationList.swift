//
//  AIMilestoneList.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIMilestoneCreationList: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @Binding var milestones: [Milestone]
    @Binding var createMilestoneSheet: Bool
    
    var body: some View {
        if milestones.isEmpty {
            NotFoundView(
                imageName: ImageNames.noMilestones,
                title: "No Milestones",
                verticalPadding: 40,
                subtitle: "Tap to add new milestone to you goal",
                action: { createMilestoneSheet.toggle() }
            )
        } else {
            LazyVStack(spacing: 12){
                ForEach($milestones, id: \.self) { milestone in
                    AIMilestoneRow(
                        milestone: milestone,
                        onDelete: onDelete
                    )
                }
            }
            .animation(.bouncy, value: milestones)
        }
    }
    
    private func onDelete(milestone: Milestone) {
        milestones.removeAll { $0.id == milestone.id }
    }
}

#Preview {
    AIMilestoneCreationList(milestones: .constant(Milestone.sampleMilestones), createMilestoneSheet: .constant(false))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(HomeCoordinator())
}
