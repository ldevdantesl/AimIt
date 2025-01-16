//
//  View+Extensions.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

extension View {
    func topSafeAreaContent() -> some View {
        self.modifier(TopSafeAreaOverlayModifier())
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func chartAppearence() -> some View {
        self.modifier(ChartSizingAndPaddingModifier())
    }
}
