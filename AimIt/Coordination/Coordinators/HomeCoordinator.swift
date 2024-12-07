//
//  HomeCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

final class HomeCoordinator: ObservableObject, HomeCoordinating {
    @Published var path: NavigationPath = NavigationPath()
    
    func navigateTo(screen: HomeScreens) {
        switch screen {
        case .goalDetails(let goal):
            path.append(goal)
        case .goalMilestones(let milestone):
            path.append(milestone)
        case .addGoal:
            path.append("NewGoal")
        case .editGoal(let goal):
            path.append(goal)
        }
    }
}
