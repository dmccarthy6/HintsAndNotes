//
//  CameraPermissionsManager.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/24/25.
//

import AVKit
import Foundation
import SwiftUI

protocol CameraPermissions {
    var currentAVAuthStatus: AVAuthorizationStatus { get set }

    func requestCameraPermissionsIfNeeded() async
}

@Observable
final class CameraPermissionsManager: CameraPermissions {
    var currentAVAuthStatus: AVAuthorizationStatus
    let mediaType: AVMediaType

    init(currentAVAuthStatus: AVAuthorizationStatus = .notDetermined,
         mediaType: AVMediaType) {
        self.currentAVAuthStatus = currentAVAuthStatus
        self.mediaType = mediaType
    }

    func requestCameraPermissionsIfNeeded() async {
        guard currentAVAuthStatus == .notDetermined else {
            currentAVAuthStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
            return
        }
        await AVCaptureDevice.requestAccess(for: mediaType)
        currentAVAuthStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
    }
}
