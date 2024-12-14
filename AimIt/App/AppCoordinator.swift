//
//  AppCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import SwiftUI

final class AppCoordinator: ObservableObject {
    
    enum AppState {
        case splash
        case authenticated
        case unauthenticated
    }
    
    @Published var appState: AppState = .splash
    
    private var isFirstLaunchKey = ConstantKeys.isFirstLaunchKey
    
    private lazy var homeCoordinator: HomeCoordinator = {
        HomeCoordinator()
    }()
    
    private lazy var settingsCoordinator: SettingsCoordinator = {
        SettingsCoordinator()
    }()
    
    private lazy var launchCoordinator: LaunchCoordinator = {
        LaunchCoordinator(onFinish: self.finishLaunch)
    }()
    
    @ViewBuilder
    func start() -> some View {
        ZStack{
            switch appState {
            case .splash:
                SplashScreen(onFinish: checkAuthentication)
                    .transition(.slide)
            case .authenticated:
                homeCoordinator.start()
                    .transition(.move(edge: .leading))
            case .unauthenticated:
                launchCoordinator.start()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.bouncy, value: appState)
    }
    
    private func finishLaunch() {
        DispatchQueue.main.async {
            self.appState = .authenticated
            UserDefaults.standard.set(false, forKey: self.isFirstLaunchKey)
        }
    }
    
    private func checkAuthentication() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let isFirstLaunch = UserDefaults.standard.object(forKey: self.isFirstLaunchKey) == nil ?
            true : UserDefaults.standard.bool(forKey: self.isFirstLaunchKey)
            self.appState = isFirstLaunch ? .unauthenticated : .authenticated
        }
    }
}
