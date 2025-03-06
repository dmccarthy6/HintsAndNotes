//
//  AddWineButton.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/4/25.
//

import SwiftUI

struct AddWineButton: View {
    @Environment(\.colorPalette)
    var palette

    let action: VoidClosure

    var body: some View {
        Button(action: action) {
            HNTextView(text: "+",
                       foreground: palette.textPrimary,
                       background: .clear,
                       font: .largeTitle,
                       bold: true)
            .frame(maxWidth: .infinity, idealHeight: 25)
        }
        .buttonStyle(.hnPrimary)

    }
}

#Preview {
    AddWineButton(action: {})
}
