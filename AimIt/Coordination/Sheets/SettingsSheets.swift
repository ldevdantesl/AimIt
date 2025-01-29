//
//  SettingsSheets.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import Foundation
import SwiftUI

enum SettingsSheets: Identifiable {
    case totalWorkspaces
    case themeColor
    
    var id: UUID { UUID() }
    
    var detents: Set<PresentationDetent> {
        switch self {
        case .totalWorkspaces:
            return [.fraction(1/3), .medium]
        case .themeColor:
            return [.height(120)]
        }
    }
}
