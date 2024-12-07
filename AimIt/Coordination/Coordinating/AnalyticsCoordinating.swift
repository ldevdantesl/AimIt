//
//  AnalyticsCoordinating.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

protocol AnalyticsCoordinating: Coordinator {
    func navigateTo(screen: AnalyticsScreens)
}
