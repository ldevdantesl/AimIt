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
    case addMilestoneToGoal(String, Binding<[Milestone]>)
    case quote(QuoteViewModel)
    
    var id: UUID { UUID() }
    
    var detents: Set<PresentationDetent> {
        switch self {
        case .addWorkspace:
            return [.fraction(1/3), .medium]
        case .quote:
            return [.fraction(1/6), .fraction(1/5)]
        case .addMilestoneToGoal:
            return [.large]
        }
    }
}
