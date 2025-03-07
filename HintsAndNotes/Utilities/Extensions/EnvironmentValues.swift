//
//  Database+EnvironmentValues.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/7/25.
//

import SwiftUI

extension EnvironmentValues {
    var colorPalette: Color.Palette {
        get {
            return self[ColorPaletteKey.self]
        }
        set {
            self[ColorPaletteKey.self] = newValue
        }
    }

    var wineLabelRepo: WineLabelRepo {
        get {
            return self[WineLabelRepoKey.self]
        }
    }
}
