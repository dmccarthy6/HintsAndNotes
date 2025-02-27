//
//  CapturePhotoViewModel.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/26/25.
//

import Foundation
import SwiftUI

@Observable
final class CapturePhotoViewModel {
    let permissionsManager = CameraPermissionsManager(mediaType: .video)
    let sessionManager = CaptureSessionManager()
    let textManager = TextRecognitionManager()
    var error: Error?
    var image: Image?

    func requestPermissionIfNeededAndConfigureSession() async {
        await requestCameraPermissionsIfNeeded()
        await configureCaptureSession()
    }

    private func requestCameraPermissionsIfNeeded() async {
        await permissionsManager.requestCameraPermissionsIfNeeded()
    }

    private func configureCaptureSession() async {
        do {
            try sessionManager.configureSession()
        } catch {
            HNLog.debug(category: .captureSession,
                        message: "Error configuring capture session. Error: \(error.localizedDescription)")
            self.error = error
        }
    }

    func takePhoto() {
        Task {
            do {
                let uiImage = try await sessionManager.capturePhoto()
                self.image = Image(uiImage: uiImage)
                try await textManager.recognizeText(in: uiImage)
            } catch {
                HNLog.debug(category: .captureSession,
                            message: "Error capturing photo. Error: \(error.localizedDescription)")
                self.error = error
            }
        }
    }
}
