//
//  MainCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import Foundation
import SwiftUI

final class TabCoordinator: ObservableObject, Coordinator {
    @Published var selectedTab: CustomTab = .home
    
    public lazy var homeCoordinator: HomeCoordinator = {
        HomeCoordinator()
    }()
    
    public lazy var analyticsCoordinator: AnalyticsCoordinator = {
        AnalyticsCoordinator()
    }()
    
    public lazy var settingsCoordinator: SettingsCoordinator = {
        SettingsCoordinator()
    }()
    
    @ViewBuilder
    func start() -> some View {
        CoreView()
            .environmentObject(self)
    }
}
