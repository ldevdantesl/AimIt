//
//  NavigationDestinationForGoal.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct NavigationDestinationForHomeScreens: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: HomeScreens.self) { screen in
                switch screen {
                case .addGoal:
                    AddGoalView()
                
                default:
                    EmptyView()
                }
            }
    }
}
