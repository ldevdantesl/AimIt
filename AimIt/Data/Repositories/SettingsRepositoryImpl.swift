//
//  SettingsRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

final class SettingsRepositoryImpl: SettingsRepository {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func getSetting<T>(forKey key: String, defaultValue: T) -> T {
        return defaults.object(forKey: key) as? T ?? defaultValue
    }
    
    func setSetting<T>(value: T, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func removeSetting(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
