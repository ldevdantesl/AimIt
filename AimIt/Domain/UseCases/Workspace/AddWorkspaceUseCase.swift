//
//  AddWorkspaceUseCase.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

protocol AddWorkspaceUseCase {
    func execute(title: String, goals: [Goal]) throws
}
