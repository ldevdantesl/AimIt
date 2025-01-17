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

    @State private var previousWorkspace: Workspace?
    
    var body: some View {
        NavigationStack(path: $coordinator.path){
            ScrollView{
                VStack(spacing: 15){
                    AIHeaderView (
                        rightMenu: AIButton(
                            image: .chevronDown,
                            backColor: .accent,
                            foreColor: .aiLabel
                        ),
                        title: "Track your progress in",
                        subtitle: workspaceVM.workspaceForAnalytics.title,
                        menuContent: headerMenuView
                    )
                    
                    AIGrowthIllustration()
                    
                    AICompletedAnalytics(
                        analyticsVM: analyticsVM,
                        in: workspaceVM.workspaceForAnalytics
                    )
                    
                    AIGoalBreakdownCharts(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.workspaceForAnalytics
                    )
                    
                    AICompletedGoalsAnalytics(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.workspaceForAnalytics
                    )
                    
                    AIMostPostpondedGoalAnalytics(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.workspaceForAnalytics
                    )
                    
                    AIMilestoneBreakdownChart(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.workspaceForAnalytics
                    )
                    
                    AICompletedMilestoneAnalytics(
                        analyticsVM: analyticsVM,
                        workspace: workspaceVM.workspaceForAnalytics
                    )
                }
                .padding(.bottom, 20)
                .id(workspaceVM.workspaceForAnalytics)
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
                    FloatingTabBar(menuContent: specialButtonView)
                }
            }
            .toolbarBackground(.clear, for: .bottomBar)
        }
    }
    
    @ViewBuilder
    private func headerMenuView() -> some View {
        ForEach(workspaceVM.workspaces) { workspace in
            Button{
                withAnimation {
                    self.previousWorkspace = workspaceVM.workspaceForAnalytics
                    workspaceVM.workspaceForAnalytics = workspace
                }
            } label:{
                Text(workspace.title)
            }
        }
    }
    
    @ViewBuilder
    private func specialButtonView() -> some View {
        Label("Previous Workspace", systemImage: "chevron.left")
        
        if let previousWorkspace {
            Button{
                withAnimation {
                    let prevWork = previousWorkspace
                    self.previousWorkspace = workspaceVM.workspaceForAnalytics
                    workspaceVM.workspaceForAnalytics = prevWork
                }
            } label: {
                Text(previousWorkspace.title)
            }
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
