//
//  SetSettingUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

protocol SetSettingUseCase {
    func execute<T>(value: T, forKey key: String)
}
