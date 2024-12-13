//
//  SettingsCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

final class SettingsCoordinator: ObservableObject{
    @Published var path: NavigationPath = NavigationPath()
    
    func start() {
        navigateTo(screen: .account)
    }
    
    func navigateTo(screen: SettingsScreens) {
        path.append(screen)
    }
}
