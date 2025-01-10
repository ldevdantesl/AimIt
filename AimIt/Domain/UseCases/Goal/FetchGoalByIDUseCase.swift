//
//  FetchGoalByIDUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 10.01.2025.
//

import Foundation

protocol FetchGoalByIDUseCase {
    func execute(id: UUID) throws -> Goal
}
