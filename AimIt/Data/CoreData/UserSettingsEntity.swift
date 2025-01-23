//
//  UserSettingsEntity+CoreDataClass.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//
//

import Foundation
import CoreData

@objc(UserSettingsEntity)
public class UserSettingsEntity: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSettingsEntity> {
        return NSFetchRequest<UserSettingsEntity>(entityName: "UserSettingsEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var fullName: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var themeColor: String?
    @NSManaged public var isNotificationEnabled: Bool
    @NSManaged public var isFirstEntry: Bool
    @NSManaged public var isCloudSyncEnabled: Bool
}
