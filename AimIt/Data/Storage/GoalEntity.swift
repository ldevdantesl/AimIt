//
//  GoalEntity+CoreDataClass.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//
//

import Foundation
import CoreData

@objc(GoalEntity)
public class GoalEntity: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalEntity> {
        return NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
    }

    @NSManaged public var category: String
    @NSManaged public var completedAt: Date?
    @NSManaged public var createdAt: Date
    @NSManaged public var deadline: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String
    @NSManaged public var milestones: NSSet?
    @NSManaged public var workspace: WorkspaceEntity

}

extension GoalEntity: Identifiable {

    @objc(addMilestonesObject:)
    @NSManaged public func addToMilestones(_ value: MilestoneEntity)

    @objc(removeMilestonesObject:)
    @NSManaged public func removeFromMilestones(_ value: MilestoneEntity)

    @objc(addMilestones:)
    @NSManaged public func addToMilestones(_ values: NSSet)

    @objc(removeMilestones:)
    @NSManaged public func removeFromMilestones(_ values: NSSet)

}
