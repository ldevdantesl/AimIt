//
//  EditWorkspaceUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

protocol EditWorkspaceUseCase {
    func execute(_ workspace: Workspace,
                 newTitle: String, newGoals: [Goal]) throws
}
