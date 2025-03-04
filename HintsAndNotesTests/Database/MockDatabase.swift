//
//  MockDatabase.swift
//  HintsAndNotesTests
//
//  Created by Dylan  on 3/4/25.
//

import CoreData
import Foundation
@testable import HintsAndNotes

struct MockDatabase {
    var databaseManager: DatabaseService {
        DatabaseService(stack: stack)
    }

    let stack: CoreDataStack

    init() {
        self.stack = CoreDataStack(inMemory: true)
    }

    func saveWine(label: WineLabel) throws -> NSManagedObject {
        let object = try databaseManager.save(object: Wine.self)
        object.id = UUID().uuidString
        object.createdAt = Date()
        object.name = label.name
        object.color = label.color
        object.year = label.vintage
        object.image = label.image
        object.type = label.type
        object.notes = label.notes
        return object
    }

    func fetch<Object: NSManagedObject>(object: Object.Type, matching id: String) throws -> Object {
        let predicate = NSPredicate(format: "id == %@", id)
        return try databaseManager.fetchRecord(ofType: Object.self, matching: predicate)
    }
}
