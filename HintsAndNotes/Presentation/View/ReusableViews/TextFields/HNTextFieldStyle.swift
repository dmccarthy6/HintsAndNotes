//
//  HNTextFieldStyle.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/7/25.
//

import SwiftUI

struct HNTextFieldStyle: TextFieldStyle {
    @Environment(\.colorPalette)
    var palette

    let image: Image?
    let showClear: Bool
    let cornerRadius: CGFloat
    let height: CGFloat
    let clearAction: OptionalClosure

    init(image: Image?,
         showClear: Bool,
         cornerRadius: CGFloat = 7,
         height: CGFloat = 40,
         _ clearAction: OptionalClosure = nil) {
        self.image = image
        self.showClear = showClear
        self.clearAction = clearAction
        self.cornerRadius = cornerRadius
        self.height = height
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    LinearGradient(colors: [palette.textPrimary, palette.textAlt],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )

            HStack {
                if let image {
                    image
                    configuration
                    if showClear {
                        Button {
                            clearAction?()
                        } label: {
                            Icons.xCircleFill
                        }
                        .padding(.trailing)
                    }
                } else {
                    configuration
                }
            }
            .padding(.leading)
            .foregroundStyle(palette.secondaryBackground)
        }
    }
}
