//
//  Milestone.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

struct Milestone: Codable, Hashable, Identifiable {
    let id: UUID
    let desc: String
    let isCompleted: Bool
    let goalID: UUID
}

extension Milestone {
    static var sample = Milestone(
        id: UUID(),
        desc: "Sample milestone",
        isCompleted: true,
        goalID: Goal.sample.id
    )
}
