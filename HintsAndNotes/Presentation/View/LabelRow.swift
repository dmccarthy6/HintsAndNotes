//
//  LabelRow.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

struct LabelRow: View {
    @Environment(\.colorPalette)
    var palette
    let name: String
    let type: String
    let image: Image?

    var body: some View {
        HStack {
            if let image {
                image
            } else {
                Image(systemName: "photo")//wineglass
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            VStack(alignment: .leading) {
                HNTextView(text: name,
                           foreground: palette.textPrimary,
                           background: .clear,
                           font: .title2)
                HNTextView(text: type,
                           foreground: palette.tertiary,
                           background: .clear,
                           font: .callout)
            }
            .padding(.leading)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    LabelRow(name: "Walt", type: "Pinot", image: nil)
}
