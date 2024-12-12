//
//  MilestoneEntity+CoreDataClass.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//
//

import Foundation
import CoreData

@objc(MilestoneEntity)
public class MilestoneEntity: NSManagedObject, Identifiable{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MilestoneEntity> {
        return NSFetchRequest<MilestoneEntity>(entityName: "MilestoneEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var desc: String
    @NSManaged public var isCompleted: Bool
    @NSManaged public var systemImage: String
    @NSManaged public var goal: GoalEntity
}
