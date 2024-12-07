//
//  AnalyticsCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

final class AnalyticsCoordinator: ObservableObject, AnalyticsCoordinating {
    @Published var path: NavigationPath = NavigationPath()
    
    func navigateTo(screen: AnalyticsScreens) {
        path.append(screen)
    }
}
