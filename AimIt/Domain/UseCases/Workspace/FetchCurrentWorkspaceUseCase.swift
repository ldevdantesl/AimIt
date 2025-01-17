//
//  FetchCurrentWorkspaceUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import Foundation

protocol FetchCurrentWorkspaceUseCase {
    func execute(by id: UUID, sortSystem: (GoalEntity, GoalEntity) -> Bool) throws -> Workspace
}
