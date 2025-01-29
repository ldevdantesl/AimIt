//
//  Coordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import Foundation
import SwiftUI

protocol Coordinator {
    associatedtype rootView: View
    
    func start() -> rootView
}
