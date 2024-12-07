//
//  RemoveSettingUseCaseImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

final class RemoveSettingUseCaseImpl: RemoveSettingUseCase {
    private let repository: SettingsRepository
    
    init(repository: SettingsRepository) {
        self.repository = repository
    }
    
    func execute(forKey key: String) {
        repository.removeSetting(forKey: key)
    }
}
