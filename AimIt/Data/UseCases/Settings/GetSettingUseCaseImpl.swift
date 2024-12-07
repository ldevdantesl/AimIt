//
//  GetSettingUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

final class GetSettingUseCaseImpl: GetSettingUseCase {
    private let repository: SettingsRepository
    
    init(repository: SettingsRepository) {
        self.repository = repository
    }
    
    func execute<T>(forKey key: String, defaultValue: T) -> T {
        return repository.getSetting(forKey: key, defaultValue: defaultValue)
    }
}
