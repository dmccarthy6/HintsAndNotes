//
//  CameraThumbnailView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/28/25.
//

import SwiftUI

struct CameraThumbnailView: View {
    let image: Image?
    private let frameWidth: CGFloat = 60
    private let frameHeight: CGFloat = 60
    private let cornerRadius: CGFloat = 10

    var body: some View {
        if let image {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frameWidth, height: frameHeight)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius,
                                            style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.white, lineWidth: 1)
                }
        } else {
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: frameWidth, height: frameHeight)
                .foregroundStyle(Color.gray.opacity(0.5))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.white, lineWidth: 1)
                }
        }
    }
}

#Preview {
    CameraThumbnailView(image: Image(systemName: "bell"))
}
