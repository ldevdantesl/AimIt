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
    var goals: [Goal]
    var prioritizedGoal: Goal?
}

extension Workspace {
    static let sample = Workspace(
        id: UUID(),
        title: "Sample Workspace",
        goals: [
            Goal(id: UUID(), workspaceID: UUID(), title: "Some Goal", isCompleted: false, deadline: .now, deadlineChanges: 0, createdAt: .now, milestones: [
                Milestone(id: UUID(), desc: "", systemImage: "", createdAt: .now, dueDate: .now, isCompleted: false, goalID: UUID())
            ])
        ]
    )
}
