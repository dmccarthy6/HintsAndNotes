//
//  TestDatabaseManager.swift
//  HintsAndNotesTests
//
//  Created by Dylan  on 3/4/25.
//

import Foundation
import Testing
@testable import HintsAndNotes

struct TestDatabaseManager {
    let database = MockDatabase()
    let testLabel = WineLabel(created: Date(),
                              name: "Test",
                              type: "Merlot",
                              color: "Red",
                              vintage: 1999,
                              image: Data(),
                              notes: "None")

    @Test
    func testAddingWineObject() async throws {
        guard let wine = try database.saveWine(label: testLabel) as? Wine else {
            return
        }
        #expect(wine.name == testLabel.name, "Names don't match")
        #expect(wine.type == testLabel.type, "Types don't match")
        #expect(wine.color == testLabel.color, "Colors don't match")
        #expect(wine.year == testLabel.vintage, "Vintages don't match")
        #expect(wine.image == testLabel.image, "Images don't match")
        #expect(wine.notes == testLabel.notes, "Notes don't match")
    }

    @Test
    func testFetchExistingWineObject() async throws {
        let wine = try database.saveWine(label: testLabel) as? Wine
        #expect(wine != nil, "Error saving wine")
        let fetchedWine = try database.fetch(object: Wine.self, matching: wine?.id ?? "99999")
        #expect(fetchedWine != nil, "Could not fetch object")
    }
}
