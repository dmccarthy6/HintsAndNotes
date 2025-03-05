//
//  WineLabel.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/28/25.
//

import Foundation

struct WineLabel {
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
}
