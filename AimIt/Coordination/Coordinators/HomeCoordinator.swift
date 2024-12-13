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
    
    @ViewBuilder
    func start() -> some View {
        HomeView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func build(screen: HomeScreens) -> some View {
        switch screen {
            
        case .addGoal:
            AddGoalView()
            
        case .goalDetails(let goal):
            GoalDetailsView(goal: goal)
            
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func build(sheet: HomeSheets) -> some View { }
    
    func present(sheet: HomeSheets) {
        self.sheet = sheet
    }
    
    func dismiss() {
        self.sheet = nil
    }
    
    func push(to screen: HomeScreens) {
        path.append(screen)
    }
    
    func goBack() {
        path.removeLast()
    }
}
