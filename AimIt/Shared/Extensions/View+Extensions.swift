//
//  View+Extensions.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

extension View {
    func setDestinationForGoal() -> some View {
        self.modifier(NavigationDestinationForGoal())
    }
}
