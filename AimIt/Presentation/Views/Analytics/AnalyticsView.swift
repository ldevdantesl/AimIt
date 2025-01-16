//
//  AnalyticsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import SwiftUI

struct AnalyticsView: View {
    @EnvironmentObject var coordinator: AnalyticsCoordinator
    @EnvironmentObject var tabCoordinator: TabCoordinator
    @EnvironmentObject var analyticsVM: AnalyticsViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    var body: some View {
        NavigationStack(path: $coordinator.path){
            ScrollView{
                VStack(spacing: 15){
                    AIHeaderView(
                        rightButton: AIButton(
                            image: .ellipsis,
                            backColor: .accent,
                            foreColor: .aiLabel,
                            action: nil
                        ),
                        title: "Track your progress",
                        subtitle: "Analytics"
                    )
                    
                    AIGrowthIllustration()
                    
                    AICompletedAnalytics(
                        analyticsVM: analyticsVM,
                        in: workspaceVM.currentWorkspace
                    )
                    
                    AIGoalBreakdownCharts(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.currentWorkspace
                    )
                    
                    AICompletedGoalsAnalytics(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.currentWorkspace
                    )
                    
                    AIMostPostpondedGoalAnalytics(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.currentWorkspace
                    )
                    
                    AIMilestoneBreakdownChart(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.currentWorkspace
                    )
                }
                .padding(.bottom, 20)
            }
            .background(Color.aiBackground)
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.build(sheet: sheet)
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { screenCover in
                coordinator.build(screenCovers: screenCover)
            }
            .navigationDestination(for: AnalyticsScreens.self) { screen in
                coordinator.build(screen: screen)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    FloatingTabBar(action: {})
                        .frame(maxWidth: .infinity)
                }
            }
            .toolbarBackground(.clear, for: .bottomBar)
        }
    }
}

#Preview {
    AnalyticsView()
        .environmentObject(AnalyticsCoordinator())
        .environmentObject(TabCoordinator())
        .environmentObject(DIContainer().makeWorkspaceViewModel())
        .environmentObject(DIContainer().makeAnalyticsViewModel())
}
