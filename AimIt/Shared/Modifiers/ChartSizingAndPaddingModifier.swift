//
//  ChartPadding.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import Foundation
import SwiftUI

struct ChartSizingAndPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 200)
            .padding(.vertical, 10)
            .padding(.top, 5)
            .padding(.horizontal, 10)
            .background(Color.aiSecondary, in: .rect(cornerRadius: 15))
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
    }
}
