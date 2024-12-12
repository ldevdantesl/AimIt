//
//  WorkspaceEntity+CoreDataClass.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//
//

import Foundation
import CoreData

@objc(WorkspaceEntity)
public class WorkspaceEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkspaceEntity> {
        return NSFetchRequest<WorkspaceEntity>(entityName: "WorkspaceEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var goals: NSSet
}

extension WorkspaceEntity {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: GoalEntity)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: GoalEntity)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}
