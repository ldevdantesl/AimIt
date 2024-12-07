//
//  SetSettingUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

final class SetSettingUseCaseImpl: SetSettingUseCase {
    private let repository: SettingsRepository
    
    init(repository: SettingsRepository) {
        self.repository = repository
    }
    
    func execute<T>(value: T, forKey key: String) {
        repository.setSetting(value: value, forKey: key)
    }
}
