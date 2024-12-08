//
//  View+Extensions.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

extension View {
    func setDestinationsForHomeScreen() -> some View {
        self.modifier(NavigationDestinationForHomeScreens())
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
