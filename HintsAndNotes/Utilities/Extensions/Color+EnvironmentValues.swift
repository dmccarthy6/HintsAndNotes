//
//  Color+EnvironmentValues.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/5/25.
//

import SwiftUI

private struct ColorPaletteKey: EnvironmentKey {
    static let defaultValue = Color.Palette.main
}

extension EnvironmentValues {
    var colorPalette: Color.Palette {
        get {
            return self[ColorPaletteKey.self]
        }
        set {
            self[ColorPaletteKey.self] = newValue
        }
    }
}
