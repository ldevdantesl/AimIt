//
//  MockSettingsRepository.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

final class MockSettingsRepository: SettingsRepository {
    private var settings: [String: Any] = [:]
    
    func getSetting<T>(forKey key: String, defaultValue: T) -> T {
        return settings[key] as? T ?? defaultValue
    }
    
    func setSetting<T>(value: T, forKey key: String) {
        settings[key] = value
    }

    func removeSetting(forKey key: String) {
        settings.removeValue(forKey: key)
    }
}
