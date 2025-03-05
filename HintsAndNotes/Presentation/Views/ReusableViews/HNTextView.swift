//
//  HNTextView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/4/25.
//

import SwiftUI

struct HNTextView: View {
    let text: String
    let foreground: Color
    let background: Color
    let font: Font
    let multilineAlignment: TextAlignment

    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(foreground)
            .background(background)
            .multilineTextAlignment(multilineAlignment)
            .frame(maxWidth: .infinity)
    }

    init(text: String,
         foreground: Color,
         background: Color,
         font: Font = .body,
         multilineAlignment: TextAlignment = .center) {
        self.text = text
        self.foreground = foreground
        self.background = background
        self.font = font
        self.multilineAlignment = multilineAlignment
    }
}

#Preview {
    HNTextView(text: "Some sample text",
               foreground: .black,
               background: .gray,
               font: .largeTitle,
               multilineAlignment: .center)
}
