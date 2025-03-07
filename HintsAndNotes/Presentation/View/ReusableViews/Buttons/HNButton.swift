//
//  HNButton.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/4/25.
//

import SwiftUI

struct HNButton: View {
    @Environment(\.colorPalette)
    var palette
    let title: String
    let isBold: Bool
    let font: Font
    let action: VoidClosure

    var body: some View {
        Button(action: action) {
            HNTextView(text: title,
                       foreground: palette.textPrimary,
                       background: .clear,
                       font: font,
                       bold: isBold)
            .frame(maxWidth: .infinity, idealHeight: 25)
        }
        .buttonStyle(.hnPrimary)

    }

    init(title: String,
         isBold: Bool = false,
         font: Font,
         action: @escaping VoidClosure) {
        self.title = title
        self.font = font
        self.isBold = isBold
        self.action = action
    }
}

#Preview {
    HNButton(title: "+", font: .largeTitle, action: {})
}
