//
//  Color+EnvironmentValues.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/5/25.
//

import SwiftUI

struct ColorPaletteKey: EnvironmentKey {
    static let defaultValue = Color.Palette.main
}

struct WineLabelRepoKey: EnvironmentKey {
    static let defaultValue = WineLabelRepo()
}
