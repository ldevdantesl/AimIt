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
    @StateObject var appCoordinator: AppCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
                .environmentObject(diContainer.makeGoalViewModel())
                .environmentObject(diContainer.makeMilestoneViewModel())
                .environmentObject(diContainer.makeWorkspaceViewModel())
                .environmentObject(diContainer.makeQuoteViewModel())
                .preferredColorScheme(.dark)
                .topSafeAreaContent()
        }
    }
}
