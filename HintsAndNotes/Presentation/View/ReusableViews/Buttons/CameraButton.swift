//
//  CameraCaptureButton.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/28/25.
//

import SwiftUI

struct CameraButton: View {
    let background: Color
    let isDisabled: Bool
    let action: VoidClosure

    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundStyle(background)
                .frame(width: 60, height: 60)
                .overlay {
                    Circle()
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 55, height: 55)
                }
        }
        .disabled(isDisabled)
    }

    init(background: Color,
         isDisabled: Bool = false,
         action: @escaping VoidClosure) {
        self.background = background
        self.isDisabled = isDisabled
        self.action = action
    }
}

#Preview {
    CameraButton(background: .red, action: {})
}
