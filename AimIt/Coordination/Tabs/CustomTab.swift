//
//  CustomTab.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import Foundation

enum CustomTab: String, CaseIterable {
    case home = "house"
    case analytics = "chart.bar.xaxis"
    case settings = "gearshape"
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .analytics: return "Analytics"
        case .settings: return "Settings"
        }
    }
    
    var specialButton: String {
        switch self {
        case .home: return "plus"
        case .analytics: return "magnifyingglass"
        case .settings: return "person"
        }
    }
}
