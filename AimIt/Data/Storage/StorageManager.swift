//
//  StorageManager.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import Foundation

protocol StorageManager {
    func getValue<T: Codable>(for key: String) -> T?
    func setValue<T: Codable>(_ value: T, for key: String)
}
