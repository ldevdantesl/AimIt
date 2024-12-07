//
//  GetSettingsUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

protocol GetSettingUseCase {
    func execute<T>(forKey key: String, defaultValue: T) -> T
}
