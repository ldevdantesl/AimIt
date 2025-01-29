//
//  AIHapticFeedbacks.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.01.2025.
//

import Foundation
import UIKit
import SwiftUI

final class AIHaptics {
    static let shared = AIHaptics()
    
    private var generators: [UIImpactFeedbackGenerator.FeedbackStyle: UIImpactFeedbackGenerator] = [:]
    
    private init() {
        generators[.light] = UIImpactFeedbackGenerator(style: .light)
        generators[.medium] = UIImpactFeedbackGenerator(style: .medium)
        generators[.heavy] = UIImpactFeedbackGenerator(style: .heavy)
        
        generators.values.forEach { $0.prepare() }
    }
    
    func generate(
        with style: UIImpactFeedbackGenerator.FeedbackStyle = .medium,
        intensity: CGFloat? = nil
    ) {
        if let generator = generators[style] {
            generator.prepare()
    
            if let intensity = intensity {
                generator.impactOccurred(intensity: intensity)
            } else {
                generator.impactOccurred()
            }
            
            generator.prepare()
        }
    }
}
