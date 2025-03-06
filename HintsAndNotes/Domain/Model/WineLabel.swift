//
//  WineLabel.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/28/25.
//

import Foundation

struct WineLabel: Hashable {
    var id: String
    /// The date the wine label is added/created
    let created: Date
    /// Wine name
    let name: String
    /// Wine type
    let type: String
    /// Wine color
    let color: String
    /// The vintage (year) of the wine
    let vintage: Double
    /// Label image in Data
    let image: Data
    /// Notes about the wine, if any.
    let notes: String

    init(created: Date,
         name: String,
         type: String,
         color: String,
         vintage: Double,
         image: Data,
         notes: String) {
        self.id = UUID().uuidString
        self.created = created
        self.name = name
        self.type = type
        self.color = color
        self.vintage = vintage
        self.image = image
        self.notes = notes
    }
}
