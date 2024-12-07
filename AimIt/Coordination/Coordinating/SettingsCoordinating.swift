//
//  SettingsCoordinating.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

protocol SettingsCoordinating: Coordinator {
    func navigateTo(screen: SettingsScreens)
}
