//
//  Goal.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

struct Goal: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let desc: String?
    let isCompleted: Bool
    let deadline: Date?
    let createdAt: Date
    let completedAt: Date?
    let milestones: [Milestone]
}

extension Goal {
    static var sample = Goal(
        id: UUID(),
        title: "Sample goal",
        desc: "Sample description",
        isCompleted: false,
        deadline: nil,
        createdAt: Date(),
        completedAt: nil,
        milestones: []
    )
}
