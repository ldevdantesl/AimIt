//
//  FetchGoalsUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol FetchGoalsUseCase {
    func execute() throws -> [Goal]
}
