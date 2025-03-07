//
//  CameraCaptureButton.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/28/25.
//

import SwiftUI

struct CameraButton: View {
    let backgroundColor: Color
    let action: VoidClosure

    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundStyle(backgroundColor)
                .frame(width: 60, height: 60)
                .overlay {
                    Circle()
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 55, height: 55)
                }
        }
    }
}

#Preview {
    CameraButton(backgroundColor: .red, action: {})
}
