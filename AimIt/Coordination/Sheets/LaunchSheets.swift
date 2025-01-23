//
//  LaunchSheets.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 22.01.2025.
//

import SwiftUI

enum LaunchSheets: Identifiable {
    case photoPicker(Binding<UIImage?>)
    
    var id: UUID { UUID() }
}
