//
//  CoreDataStack.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/4/25.
//

import CoreData

enum DatabaseError: Error {
    case invalidEntity(String)
    case invalidType
    case loadingPersistentStore
    case noChanges
    case unhandled(Error)

    var description: String {
        switch self {
        case .invalidEntity(let named): return "Could not find entity matching name: \(named)."
        case .invalidType: return "Error converting managedObject type."
        case .loadingPersistentStore: return "Error loading persistent stores."
        case .noChanges: return "No changes to managed object context."
        case .unhandled(let error): return "Unhandled Core Data Error - \(error.localizedDescription)"
        }
    }
}

class CoreDataStack {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HintsAndNotes")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "dev/null", directoryHint: .notDirectory)
        }
        container.loadPersistentStores { storeDescription, error in
            if let error {
                HNLog.debug(category: .database, message: "Error loading persistent stores. Error: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    let inMemory: Bool

    init(inMemory: Bool = false) {
        self.inMemory = inMemory
    }
}
