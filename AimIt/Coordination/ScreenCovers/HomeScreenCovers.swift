//
//  HomeScreenCover.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 27.12.2024.
//

import Foundation
import SwiftUI

enum HomeScreenCovers: Identifiable {
    case editGoal(Binding<Goal>)
    
    var id: UUID { UUID() }
}
