//
//  AnalyticsSheets.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import Foundation
import SwiftUI

enum AnalyticsSheets: Identifiable {
    case selectWorkspace
    
    var id: UUID { UUID() }
    
    var detents: Set<PresentationDetent>  {
        switch self {
        case .selectWorkspace:
            return [.medium]
        }
    }
}
