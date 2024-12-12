//
//  Workspace.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation

struct Workspace: Identifiable, Hashable, Codable {
    let id: UUID
    let title: String
    let goals: [Goal]
}

extension Workspace {
    static let sample = Workspace(
        id: UUID(),
        title: "Sample Workspace",
        goals: [
            .sample,
            .sample,
            .sample
        ]
    )
}
