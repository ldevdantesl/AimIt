//
//  HomeCoordinating.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

protocol HomeCoordinating: Coordinator {
    func navigateTo(screen: HomeScreens)
}
