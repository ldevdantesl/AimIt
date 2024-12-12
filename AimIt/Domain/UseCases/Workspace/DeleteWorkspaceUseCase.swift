//
//  DeleteWorkspaceUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

protocol DeleteWorkspaceUseCase {
    func execute(_ workspace: Workspace) throws
}
