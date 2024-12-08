//
//  UIConstants.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

enum UIConstants {
    static let backgroundColor = LinearGradient(
        colors: [
            .aiBackground,
            .aiBackground.opacity(0.95)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    static let halfWidth: CGFloat = (screenWidth / 2) - 20
    static let halfHeight: CGFloat = (screenHeight / 2) - 20
}
