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
            AIGoalCard(prioritizedGoal: goal)
                .contextMenu {
                    Button(
                        "Unprioritize",
                        systemImage: "exclamationmark.questionmark",
                        action: unprioritize
                    )
                }
                .id(workspace.prioritizedGoal)
        }
    }
    
    private func unprioritize() {
        DispatchQueue.main.async {
            workspaceVM.unprioritizeGoal(in: workspace)
        }
    }
}

#Preview {
    AIPrioritizedGoalCard(in: .sample)
}
