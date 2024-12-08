//
//  AimItApp.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import SwiftUI

@main
struct AimItApp: App {
    @StateObject var diContainer: DIContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(diContainer.makeAppCoordinator())
                .environmentObject(diContainer.makeGoalViewModel())
                .environmentObject(diContainer.makeMilestoneViewModel())
                .preferredColorScheme(.dark)
                .topSafeAreaContent()
        }
    }
}
