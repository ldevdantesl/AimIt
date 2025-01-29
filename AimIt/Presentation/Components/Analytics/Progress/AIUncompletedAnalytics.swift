//
//  AIUncompletedAnalytics.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation
import SwiftUI
import Charts

struct AIUncompletedAnalytics: View {
    
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, in workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    var body: some View {
        AIInfoField(
            title: "Uncompleted Goals & Milestones",
            titleFontStyle: .subheadline,
            info: nil
        )
    }
}

#Preview {
    AIUncompletedAnalytics(analyticsVM: DIContainer().makeAnalyticsViewModel(), in: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
