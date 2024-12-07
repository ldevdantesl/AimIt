//
//  SettingsCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

final class SettingsCoordinator: ObservableObject, SettingsCoordinating {
    @Published var path: NavigationPath = NavigationPath()
    
    func navigateTo(screen: SettingsScreens) {
        path.append(screen)
    }
}
