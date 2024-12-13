//
//  Coordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

protocol Coordinator{
    associatedtype RootView: View
    
    var path: NavigationPath { get set }
    
    @ViewBuilder
    func start() -> RootView
}
