//
//  Goal.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

struct Goal: Identifiable, Codable, Hashable {
    let id: UUID
    var workspaceID: UUID
    var title: String
    var desc: String?
    var isCompleted: Bool
    var deadline: Date
    var deadlineChanges: Int
    var createdAt: Date
    var completedAt: Date?
    var milestones: [Milestone]
}

extension Goal {
    static var sample = Goal(
        id: UUID(),
        workspaceID: Workspace.sample.id,
        title: "Learn UIKit",
        desc: "Finish UIKit till next week and learn SwiftUI",
        isCompleted: false,
        deadline: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
        deadlineChanges: 0,
        createdAt: Date(),
        completedAt: nil,
        milestones: Array(
            repeating: Milestone(
                id: UUID(),
                desc: "some description",
                systemImage: "folder",
                createdAt: .now,
                dueDate: .now,
                isCompleted: false,
                goalID: UUID()
            ),
            count: 3)
    )
}
