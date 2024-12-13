//
//  UserDefaultsStorageManager.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import Foundation

final class UserDefaultsStorageManager: StorageManager {
    private let userDefaults = UserDefaults.standard
    
    func getValue<T: Codable>(for key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func setValue<T: Codable>(_ value: T, for key: String) {
        if let data = try? JSONEncoder().encode(value) {
            userDefaults.set(data, forKey: key)
        }
    }
}
