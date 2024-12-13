//
//  AnalyticsCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

final class AnalyticsCoordinator: ObservableObject{
    @Published var path: NavigationPath = NavigationPath()
    
    func start() {
        navigateTo(screen: .someScreen)
    }
    
    func navigateTo(screen: AnalyticsScreens) {
        path.append(screen)
    }
}
