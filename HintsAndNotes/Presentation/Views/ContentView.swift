//
//  ContentView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = CapturePhotoViewModel()

    var body: some View {
        VStack {
            if let image = viewModel.image {
                image
                    .resizable()
                    .frame(maxWidth: .infinity, idealHeight: 375)
                Spacer()
            } else {
                CameraView(session: viewModel.sessionManager.session)
                
                Button {
                    viewModel.takePhoto()
                } label: {
                    Text("Take Photo")
                }
            }

        }
            .task {
                await viewModel.requestPermissionIfNeededAndConfigureSession()
            }
    }
}

#Preview {
    ContentView()
}
