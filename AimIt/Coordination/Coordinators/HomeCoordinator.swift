//
//  HomeCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

final class HomeCoordinator: ObservableObject, Coordinator {
    @Published var path: NavigationPath = NavigationPath()
    
    @Published var sheet: HomeSheets?
    @Published var fullScreenCover: HomeScreenCovers?
    
    @ViewBuilder
    func start() -> some View {
        HomeView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func build(screen: HomeScreens) -> some View {
        switch screen {
            
        case .addGoal:
            HomeAddGoalView()
            
        case .goalDetails:
            GoalDetailsView()
            
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func build(sheet: HomeSheets) -> some View {
        NavigationStack{
            switch sheet {
            case .addWorkspace:
                HomeAddWorkspaceView()
                    .presentationDetents(sheet.detents)
                    .presentationDragIndicator(.visible)
            case .quote(let quoteVM):
                AIQuoteSheet(quoteVM: quoteVM)
                    .presentationDetents(sheet.detents)
                    .presentationDragIndicator(.visible)
            case .addMilestoneToGoal(let goalTitle, let milestones):
                CreateMilestoneSheet(goalTitle: goalTitle, milestones: milestones)
                    .presentationDetents(sheet.detents)
            }
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: HomeScreenCovers) -> some View {
        NavigationStack{
            switch fullScreenCover {
            case .editGoal:
                EditGoalScreenCover()
            }
        }
    }
    
    func present(sheet: HomeSheets) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: HomeScreenCovers) {
        self.fullScreenCover = fullScreenCover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    func push(to screen: HomeScreens) {
        path.append(screen)
    }
    
    func goBack() {
        path.removeLast()
    }
}
