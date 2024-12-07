//
//  CoreDataStack.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AimIt")
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Error loading persistent store: \(error)")
            }
        }
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    
    func saveContext(context: NSManagedObjectContext? = nil) throws {
        let contextToSave = context ?? viewContext
        if contextToSave.hasChanges {
            try contextToSave.save()
        }
    }
}
