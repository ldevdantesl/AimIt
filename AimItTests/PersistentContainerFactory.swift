//
//  PersistentContainerFactory.swift
//  AimItTests
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import Foundation
import CoreData

final class PersistentContainerFactory {
    static func makeMemoryPersistentContainer(modelName: String) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: modelName)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("Failed to load persistent stores: \(error!)")
            }
        }
        return container
    }
}
