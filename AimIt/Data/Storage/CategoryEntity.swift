//
//  CategoryEntity+CoreDataClass.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//
//

import Foundation
import CoreData

@objc(CategoryEntity)
public class CategoryEntity: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
}

extension CategoryEntity: Identifiable {
    
}
