//
//  AIPrioritizedGoalCard.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 3.01.2025.
//

import Foundation
import SwiftUI

struct AIPrioritizedGoalCard: View {
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    private var workspace: Workspace
    
    init(in workspace: Workspace) {
        self.workspace = workspace
    }
    
    var body: some View {
        if let goal = workspace.prioritizedGoal {
            AIGoalCard(goal: goal, prioritized: true)
                .contextMenu {
                    Button(
                        "Unprioritize",
                        systemImage: "exclamationmark.questionmark",
                        action: unprioritize
                    )
                }
                .transition(.move(edge: .bottom))
        }
    }
    
    private func unprioritize() {
        DispatchQueue.main.async {
            withAnimation(.bouncy) {
                workspaceVM.unprioritizeGoal(in: workspace)
            }
        }
    }
}

#Preview {
    AIPrioritizedGoalCard(in: .sample)
}
