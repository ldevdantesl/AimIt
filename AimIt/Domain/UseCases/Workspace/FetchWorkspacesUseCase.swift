//
//  FetchWorkspacesUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

protocol FetchWorkspacesUseCase {
    func execute() throws -> [Workspace]
}
