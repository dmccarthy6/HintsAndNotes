//
//  DashboardViewModel.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/4/25.
//

import SwiftUI

@Observable
final class DashboardViewModel {
    var allWines: [WineLabel] = []
    var error: Error?
    var selectedWine = ""
    var showCamera = false
    let noLabelsText = "Looks like you don't have any labels yet. Let's add one."

    let repo: WineLabelRepo

    init(repo: WineLabelRepo) {
        self.repo = repo
    }

    func getWines() {
        do {
            allWines = try repo.getAllWines()
        } catch {
            self.error = error
        }
    }

    func addNew(wine: WineLabel) {
        do {
            try repo.save(wine: wine)
            allWines = try repo.getAllWines()
        } catch {
            self.error = error
        }
    }
}
