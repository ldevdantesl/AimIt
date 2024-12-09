//
//  Goal.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

struct Goal: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var desc: String?
    var isCompleted: Bool
    var deadline: Date?
    var createdAt: Date
    var completedAt: Date?
    var milestones: [Milestone]
}

extension Goal {
    static var sample = Goal(
        id: UUID(),
        title: "Learn UIKit",
        desc: "Finish UIKit till next week and learn SwiftUI",
        isCompleted: false,
        deadline: .now,
        createdAt: Date(),
        completedAt: nil,
        milestones: [
            Milestone(id: UUID(), desc: "Milestone 1", systemImage: "bookmark", isCompleted: true, goalID: UUID()),
            Milestone(id: UUID(), desc: "Milestone 2", systemImage: "house", isCompleted: false, goalID: UUID()),
        ]
    )
}
