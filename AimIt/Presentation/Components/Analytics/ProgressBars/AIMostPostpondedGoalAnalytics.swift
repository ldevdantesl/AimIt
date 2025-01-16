//
//  AIMostPostpondedGoalAnalytics.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import SwiftUI

struct AIMostPostpondedGoalAnalytics: View {
    
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    @State private var mostPostpondedGoal: Goal?
    
    var body: some View {
        if let goal = mostPostpondedGoal {
            VStack {
                AIInfoField(
                    title: "Most postponded goal",
                    info: nil
                )
            }
        }
    }
    
    private func setup() {
        DispatchQueue.main.async {
            withAnimation {
                
            }
        }
    }
}

#Preview {
    AIMostPostpondedGoalAnalytics(
        analyticsVM: DIContainer().makeAnalyticsViewModel(),
        workspace: .sample
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.aiBackground)
}
