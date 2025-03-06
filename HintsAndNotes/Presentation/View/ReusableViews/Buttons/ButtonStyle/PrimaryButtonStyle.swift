//
//  PrimaryButtonStyle.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/5/25.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.colorPalette)
    var palette

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor(isPressed: configuration.isPressed))
            .background(backgroundColor(isPressed: configuration.isPressed))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .frame(minWidth: 44, maxWidth: .infinity, minHeight: 44)
    }

    private func foregroundColor(isPressed: Bool) -> Color {
        let foreground = palette.textPrimary
        let pressedColor: Color = foreground.opacity(0.4)
        return isPressed ? pressedColor : foreground
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        let background = palette.primaryBackground
        let pressedColor: Color = background.opacity(0.1)
        return isPressed ? pressedColor : background
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var hnPrimary: PrimaryButtonStyle { .init() }
}
