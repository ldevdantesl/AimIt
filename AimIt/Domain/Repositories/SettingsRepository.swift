//
//  SettingsRepository.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

protocol SettingsRepository {
    func getSetting<T>(forKey key: String, defaultValue: T) -> T
    func setSetting<T>(value: T, forKey key: String)
    func removeSetting(forKey key: String)
}
