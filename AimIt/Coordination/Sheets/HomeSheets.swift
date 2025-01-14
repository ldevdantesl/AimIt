//
//  HomeSheets.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 12.12.2024.
//

import Foundation
import SwiftUI

enum HomeSheets: Identifiable {
    case addWorkspace
    case quote(QuoteViewModel)
    case milestoneDetails(Binding<Milestone>)
    case changeDeadline(Binding<Goal>)
    
    var id: UUID { UUID() }
    
    var detents: Set<PresentationDetent> {
        switch self {
        case .addWorkspace:
            return [.fraction(1/3), .medium]
        case .quote:
            return [.fraction(1/6), .fraction(1/5)]
        case .milestoneDetails:
            return [.fraction(1/6), .fraction(1/4)]
        case .changeDeadline:
            return [.medium, .large]
        }
    }
}
