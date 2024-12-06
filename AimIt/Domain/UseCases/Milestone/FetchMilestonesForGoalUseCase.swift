//
//  FetchMilestonesForGoalUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation

protocol FetchMilestonesForGoalUseCase {
    func execute(for goal: Goal) throws -> [Milestone]
}
