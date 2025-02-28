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
                CameraCaptureButton(backgroundColor: .white) {
                    viewModel.takePhoto()
                }.padding(.trailing, 60)
                Spacer()
            }
            .padding(.horizontal)
        }
        .task {
            await viewModel.requestPermissionIfNeededAndConfigureSession()
        }
    }
}

#Preview {
    CameraView()
}
