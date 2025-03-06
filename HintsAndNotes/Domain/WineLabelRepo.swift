//
//  WineDatabaseRepo.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/4/25.
//

import Foundation

struct WineLabelRepo {
    private let service: DatabaseService

    init(service: DatabaseService = DatabaseService()) {
        self.service = service
    }

    func getAllWines() throws -> [WineLabel] {
        let wineObjects = try service.fetchRecords(ofType: Wine.self)

        return wineObjects.map({
            WineLabel.label(from: $0)
        })
    }

    func getWine(matching id: String) throws -> WineLabel {
        let predicate = NSPredicate(format: "id == %@", id)
        let object = try service.fetchRecord(ofType: Wine.self,
                                             matching: predicate)
        return WineLabel.label(from: object)
    }

    func save(wine: WineLabel) throws {
        let object = try service.save(object: Wine.self)
        object.id = wine.id
        object.createdAt = Date()
        object.name = wine.name
        object.type = wine.type
        object.year = wine.vintage
        object.color = wine.color
        object.notes = wine.notes

        try saveDatabase()
    }

    func saveDatabase() throws {
        try service.saveContext()
    }
}

extension WineLabel {
    static func label(from wine: Wine) -> WineLabel {
        WineLabel(created: wine.createdAt ?? Date(),
                  name: wine.name ?? "none",
                  type: wine.type ?? "",
                  color: wine.color ?? "none",
                  vintage: wine.year,
                  image: wine.image ?? Data(),
                  notes: wine.notes ?? "none")
    }
}
