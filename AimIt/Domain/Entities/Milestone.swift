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
    let systemImage: String
    var isCompleted: Bool
    let goalID: Goal.ID
}

extension Milestone {
    static var sample = Milestone(
        id: UUID(),
        desc: "Sample milestone",
        systemImage: "bookmark.fill",
        isCompleted: false,
        goalID: Goal.sample.id
    )
    
    static var sampleMilestones: [Milestone] = [
        sample,
        sample,
        Milestone(
            id: UUID(),
            desc: "Sample milestone",
            systemImage: "bookmark.fill",
            isCompleted: false,
            goalID: Goal.sample.id
        )
    ]
}
