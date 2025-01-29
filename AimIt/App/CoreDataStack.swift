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
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        return createLocalContainer()
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    ///Create Local Persistent Container
    private func createLocalContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading local persistent store: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }
    
    /// Save Context
    func saveContext(context: NSManagedObjectContext? = nil) {
        let contextToSave = context ?? viewContext
        if contextToSave.hasChanges {
            do {
                try contextToSave.save()
            } catch {
                print("Error saving the context: \(error.localizedDescription)")
            }
        }
    }
    
    private func clearPersistentStore() {
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
    }
}
