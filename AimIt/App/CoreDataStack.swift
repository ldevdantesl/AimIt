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
        let container = NSPersistentContainer(name: Constants.COREDATA_MODEL)
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
    
    
    func clearPersistentStore() {
        let storeCoordinator = persistentContainer.persistentStoreCoordinator
        
        for store in storeCoordinator.persistentStores {
            do {
                try storeCoordinator.remove(store)
                if let storeURL = store.url {
                    try FileManager.default.removeItem(at: storeURL)
                }
            } catch {
                print("Error clearing Core Data store: \(error)")
            }
        }
        
        // Reload Persistent Stores
        persistentContainer = NSPersistentContainer(name: Constants.COREDATA_MODEL)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    func saveContext(context: NSManagedObjectContext? = nil) throws {
        let contextToSave = context ?? viewContext
        if contextToSave.hasChanges {
            try contextToSave.save()
        }
    }
}
