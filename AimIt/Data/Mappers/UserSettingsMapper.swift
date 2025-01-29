//
//  UserSettingsMapper.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import Foundation
import CoreData

struct UserSettingsMapper {
    static func toDomain(_ entity: UserSettingsEntity) -> UserSettings {
        return UserSettings(
            id: entity.id ?? UUID(),
            fullName: entity.fullName ?? "",
            profileImage: entity.profileImage,
            themeColor: entity.themeColor ?? "#F55702",
            isFirstEntry: entity.isFirstEntry,
            isCloudSyncEnabled: entity.isCloudSyncEnabled,
            isNotificationEnabled: entity.isNotificationEnabled
        )
    }
    
    static func toEntity(_ domain: UserSettings, context: NSManagedObjectContext) -> UserSettingsEntity {
        let request: NSFetchRequest<UserSettingsEntity> = UserSettingsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", domain.id.uuidString)
        
        if let existingEntity = try? context.fetch(request).first {
            return existingEntity
        } else {
            let userSettings = UserSettingsEntity(context: context)
            userSettings.id = domain.id
            userSettings.fullName = domain.fullName
            userSettings.profileImage = domain.profileImage
            userSettings.themeColor = domain.themeColor
            userSettings.isCloudSyncEnabled = domain.isCloudSyncEnabled
            userSettings.isFirstEntry = domain.isFirstEntry
            userSettings.isNotificationEnabled = domain.isNotificationEnabled
            return userSettings
        }
    }
}
