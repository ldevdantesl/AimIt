//
//  NavigationDestinationForGoal.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct NavigationDestinationForGoal: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Goal.self) { goal in
                GoalDetailsView(goal: goal)
            }
    }
}
