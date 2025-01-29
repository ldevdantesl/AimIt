//
//  UIColor+Extensions.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import SwiftUI

extension UIColor {
    func toHexString() -> String? {
        guard let components = self.cgColor.components else { return nil }
        let red = Int(components[0] * 255)
        let green = Int(components[1] * 255)
        let blue = Int(components[2] * 255)
        let alpha = Int((components.count > 3 ? components[3] : 1.0) * 255)
        
        return String(format: "#%02X%02X%02X%02X", red, green, blue, alpha)
    }
    
    static func fromHexString(_ hex: String) -> UIColor? {
        var hexString = hex
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }
        
        guard hexString.count == 8, let hexValue = UInt64(hexString, radix: 16) else { return nil }
        
        let red = CGFloat((hexValue >> 24) & 0xFF) / 255.0
        let green = CGFloat((hexValue >> 16) & 0xFF) / 255.0
        let blue = CGFloat((hexValue >> 8) & 0xFF) / 255.0
        let alpha = CGFloat(hexValue & 0xFF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
    
