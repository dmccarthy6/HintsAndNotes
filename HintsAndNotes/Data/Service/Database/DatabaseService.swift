//
//  DatabaseService.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/28/25.
//

import CoreData

final class DatabaseService {
    let stack: CoreDataStack

    init(stack: CoreDataStack = CoreDataStack(inMemory: false)) {
        self.stack = stack
    }

    // MARK: - Save

    func save<Object: NSManagedObject>(object: Object.Type) throws -> Object {
        let entityName = Object.description()
        guard let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                      in: stack.context) else {
            throw DatabaseError.invalidEntity(entityName)
        }
        let record = Object(entity: entity, insertInto: stack.context)
        return record
    }

    // MARK: - Update

    func update<Object: NSManagedObject>(object: Object) {
        // TODO: Implement
    }

    // MARK: - Delete

    func delete(_ record: NSManagedObject) {
        stack.context.delete(record)
    }

    func deleteAll<Object: NSManagedObject>(_ type: Object.Type, predicate: NSPredicate? = nil) throws {
        let results = try query(type, predicate: predicate)

        for object in results {
            stack.context.delete(object)
        }
    }

    func saveContext() throws {
        guard stack.context.hasChanges else {
            throw DatabaseError.noChanges
        }
        try stack.context.save()
    }

    // MARK: - Fetch

    func fetchRecords<Object: NSManagedObject>(ofType: Object.Type,
                                               sort: NSSortDescriptor? = nil) throws -> [Object] {
        let request = fetchRequest(for: Object.self, sortDescriptor: sort)
        let results = try stack.context.fetch(request)

        guard let records = results as? [Object] else {
            throw DatabaseError.invalidType
        }
        return records
    }

    func fetchRecord<Object: NSManagedObject>(ofType: Object.Type,
                                              matching predicate: NSPredicate) throws -> Object {
        let request = fetchRequest(for: Object.self, predicate: predicate)
        let result = try stack.context.fetch(request)
        guard let objects = result as? [Object],
              let object = objects.first else {
            throw DatabaseError.invalidType
        }
        return object
    }

    private func query<Object: NSManagedObject>(_ type: Object.Type,
                                                predicate: NSPredicate?,
                                                sort: NSSortDescriptor? = nil) throws -> [Object] {
        let fetchRequest = fetchRequest(for: Object.self, predicate: predicate, sortDescriptor: sort)
        let fetchResults = try stack.context.fetch(fetchRequest)

        guard let results = fetchResults as? [Object] else {
            throw DatabaseError.invalidType
        }
        return results
    }

    private func fetchRequest<Object: NSManagedObject>(for object: Object.Type,
                                                       predicate: NSPredicate? = nil,
                                                       sortDescriptor: NSSortDescriptor? = nil) -> NSFetchRequest<NSFetchRequestResult> {
        let request = Object.fetchRequest()
        if let predicate {
            request.predicate = predicate
        }
        if let sortDescriptor {
            request.sortDescriptors = [sortDescriptor]
        }
        return request
    }
}
