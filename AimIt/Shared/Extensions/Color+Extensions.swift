//
//  Color+Extensions.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import SwiftUI

extension Color {
    func toHexString() -> String? {
        let uiColor = UIColor(self)
        return uiColor.toHexString()
    }
    
    static func fromHexString(_ hex: String) -> Color? {
        guard let uiColor = UIColor.fromHexString(hex) else { return nil }
        return Color(uiColor)
    }
}
