//
//  CameraView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/28/25.
//

import SwiftUI

struct CameraView: View {
    @State private var viewModel = CapturePhotoViewModel()

    var body: some View {
        VStack {
            CameraViewRepresentable(session: viewModel.sessionManager.session)

            HStack {
                CameraThumbnailView(image: viewModel.image)
                Spacer()
                CameraButton(background: .white) {
                    viewModel.takePhoto()
                }
                .padding(.trailing, 60)
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBar(title: "Add Label",
                       trailingLabel: "Dismiss") {
            // TODO: Dismiss view
        }
        .task {
            await viewModel.requestPermissionIfNeededAndConfigureSession()
        }
    }
}

#Preview {
    CameraView()
}
