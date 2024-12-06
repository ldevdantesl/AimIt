//
//  PersistentContainerFactory.swift
//  AimItTests
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation
import CoreData
@testable import AimIt

final class PersistentContainerFactory {
    static func makeInMemoryCoreDataStack(modelName: String) -> CoreDataStack {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        let coreDataStack = CoreDataStack(modelName: modelName)

        // Remove any previously loaded persistent stores
        let persistentStoreCoordinator = coreDataStack.persistentContainer.persistentStoreCoordinator
        for store in persistentStoreCoordinator.persistentStores {
            do {
                try persistentStoreCoordinator.remove(store)
            } catch {
                fatalError("Failed to remove persistent store: \(error)")
            }
        }

        // Add in-memory store description
        coreDataStack.persistentContainer.persistentStoreDescriptions = [description]

        // Load the new in-memory persistent store
        coreDataStack.persistentContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Failed to load persistent stores: \(error!)")
            }
        }

        return coreDataStack
    }
}
