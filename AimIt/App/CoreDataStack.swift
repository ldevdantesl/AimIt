//
//  CoreDataStack.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AimIt")
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Error loading persistent store: \(error)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
}
