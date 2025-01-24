//
//  AIPrioritizedGoalCard.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 3.01.2025.
//

import Foundation
import SwiftUI

struct AIPrioritizedGoalCard: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    private let workspace: Workspace
    
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
                .shadow(color: userVM.themeColor.opacity(0.8), radius: 5, x: 0, y: 0)
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
