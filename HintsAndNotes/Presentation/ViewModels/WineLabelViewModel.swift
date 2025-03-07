//
//  AddLabelViewModel.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import Foundation
import UIKit
import SwiftUI

@Observable
final class WineLabelViewModel {
    var label: WineLabel = .empty // TODO: Should be creating this label inside this VM, Passing Image into view.
    var error: Error?
    var name = ""
    var type = ""
    var color = ""
    var vintage = ""
    var notes = ""

    let namePrompt = "Wine name"
    let typePrompt = "Wine type (e.g. Rosé)"
    let colorPrompt = "Wine color (e.g. Red)"
    let vintagePrompt = "Wine vintage (e.g. 1999)"
    let notesPrompt = "Notes"

    var image: Image {
        guard let uiImage = UIImage(data: label.image) else {
            return Icons.photo
        }
        return Image(uiImage: uiImage)
    }

    // MARK: - Database

    /// Save the specified label to the database
    /// - Parameter label: `WineLabel` object to store in database.
    func save(in repo: WineLabelRepo) {

        do {
            try repo.save(wine: label)
        } catch {
            self.error = error
        }
    }

    func setData() {
        name = label.name
        type = label.type
        color = label.color
        vintage = vintageAsString()
        notes = label.notes
    }

    func setLabel() {
        self.label = WineLabel(created: Date(),
                               name: name,
                               type: type,
                               color: color,
                               vintage: Double(vintage) ?? 0, // TODO: Fix this!
                               image: Data(),
                               notes: notes)
    }

    private func vintageAsString() -> String {
        let emptyVintage = WineLabel.empty.vintage
        let isEmpty = label.vintage == emptyVintage
        return isEmpty ? "" : "\(label.vintage)"
    }
}

private extension WineLabel {
    static var empty: WineLabel = WineLabel(created: Date(), name: "", type: "", color: "", vintage: 0, image: Data(), notes: "")
}
