//
//  UserSettings.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import Foundation

struct UserSettings: Identifiable {
    let id: UUID
    var fullName: String
    var profileImage: Data?
    let themeColor: String
    var isFirstEntry: Bool
    var isCloudSyncEnabled: Bool
    var isNotificationEnabled: Bool
}

extension UserSettings {
    static let sample: UserSettings = .init(
        id: UUID(),
        fullName: "Dantes Alciati",
        profileImage: nil,
        themeColor: "#F55702",
        isFirstEntry: true,
        isCloudSyncEnabled: true,
        isNotificationEnabled: true
    )
}
