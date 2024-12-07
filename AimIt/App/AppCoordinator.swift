//
//  AppCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

final class AppCoordinator: ObservableObject {
    func makeHomeCoordinator() -> HomeCoordinator {
        HomeCoordinator()
    }
    
    func makeSettingsCoordinator() -> SettingsCoordinator {
        SettingsCoordinator()
    }
}
