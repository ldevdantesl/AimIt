//
//  HomeScreens.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

enum HomeScreens: Identifiable, Hashable {
    case goalDetails(Binding<Goal>)
    case addGoal
    
    var id: UUID { UUID() }
    
    static func ==(lhs: HomeScreens, rhs: HomeScreens) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
