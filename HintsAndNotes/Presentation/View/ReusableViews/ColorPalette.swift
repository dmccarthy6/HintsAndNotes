//
//  ColorPalette.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/5/25.
//

import SwiftUI

extension Color {
    struct Palette {
        let name: String

        var primaryBackground: Color {
            Color(from: self.name, semantic: "background-primary")
        }

        var secondaryBackground: Color {
            Color(from: self.name, semantic: "background-secondary")
        }

        var tertiaryBackground: Color {
            Color(from: self.name, semantic: "background-tertiary")
        }

        var textPrimary: Color {
            Color(from: self.name, semantic: "text-primary")
        }

        var textAlt: Color {
            Color(from: self.name, semantic: "text-alt")
        }

        var primary: Color {
            Color(from: self.name, semantic: "primary")
        }

        var secondary: Color {
            Color(from: self.name, semantic: "secondary")
        }

        var tertiary: Color {
            Color(from: self.name, semantic: "tertiary")
        }
    }
}

private extension Color {
    init(from palette: String, semantic name: String) {
        self.init(uiColor: UIColor(named: "\(palette)/\(name)")!)
    }
}

extension Color.Palette {
    static let main = Color.Palette(name: "Main")
}
