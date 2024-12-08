//
//  MainView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    
    var body: some View {
        HomeView()
            .environmentObject(appCoordinator.makeHomeCoordinator())
            .tabItem {
                Label("Goals", systemImage: "house")
            }
    }
}

#Preview {
    MainView()
        .environmentObject(DIContainer().makeAppCoordinator())
        .environmentObject(DIContainer().makeGoalViewModel())
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
