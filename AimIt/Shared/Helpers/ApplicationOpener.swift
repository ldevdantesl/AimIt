//
//  ApplicationOpener.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import Foundation
import SwiftUI

struct ApplicationOpener {
    static func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    static func openURL(URLString: String) {
        if let url = URL(string: URLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL")
            }
        }
    }
}
