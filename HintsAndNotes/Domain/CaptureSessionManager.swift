//
//  CaptureSessionManager.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/24/25.
//

import AVKit
import SwiftUI

final class CaptureSessionManager: NSObject {
    enum CaptureSessionError: Error {
        case addInputs
        case addOutputs
        case captureDevice
    }

    let session = AVCaptureSession()
    private var deviceTypes: [AVCaptureDevice.DeviceType] {
        [
            .builtInWideAngleCamera,
            .builtInDualCamera
        ]
    }

    private let photoOutput = AVCapturePhotoOutput()
    private var photoContinuation: CheckedContinuation<UIImage, Error>?

    func configureSession() throws {
        HNLog.debug(category: .captureSession, message: "Configuring capture session....")
        session.beginConfiguration()
        session.sessionPreset = .photo
        try addInputs()
        try addOutputs()
        session.commitConfiguration()
        try startRunning()
    }

    func capturePhoto() async throws -> UIImage {
        try await withCheckedThrowingContinuation { continuation in
            photoContinuation = continuation
            let settings = photoOutputSettings()
            photoOutput.capturePhoto(with: settings, delegate: self)
        }
    }

    // MARK: - Helpers

    private func addInputs() throws {
        guard let device = bestDevice(for: .video, at: .back) else {
            throw CaptureSessionError.captureDevice
        }
        let input = try AVCaptureDeviceInput(device: device)

        if session.canAddInput(input) {
            session.addInput(input)
        } else {
            throw CaptureSessionError.addInputs
        }
    }

    private func addOutputs() throws {
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        } else {
            throw CaptureSessionError.addOutputs
        }
    }

    private func startRunning() throws {
        guard !session.isRunning else {
            return // TODO: Throw Error
        }
        session.startRunning()
    }

    private func stopRunning() {
        guard session.isRunning else {
            return // TODO: Throw?
        }
        session.stopRunning()
    }

    // Use a discovery session to obtain the best device.
    private func bestDevice(for mediaType: AVMediaType,
                            at position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
                                                       mediaType: mediaType,
                                                       position: position)
        let device = session.devices.first(where: { $0.position == position })
        return device
    }

    private func photoOutputSettings() -> AVCapturePhotoSettings {
        var settings = AVCapturePhotoSettings()

        // Add HEIC photos if supported
        if photoOutput.availablePhotoCodecTypes.contains(.hevc) {
            settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
        }

        if let previewPhotoPixelFormatType = settings.availablePreviewPhotoPixelFormatTypes.first {
            settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPhotoPixelFormatType]
        }
        return settings
    }

    private func imageOrientation() -> UIImage.Orientation {
        let currentDevice = UIDevice.current
        currentDevice.beginGeneratingDeviceOrientationNotifications()
        let deviceOrientation = currentDevice.orientation

        switch deviceOrientation {
        case .portrait: return .right
        case .portraitUpsideDown: return .down
        case .landscapeLeft: return .left
        case .landscapeRight: return .right
        case .unknown: return .up
        case .faceUp: return .right
        case .faceDown: return .right
        @unknown default: return .right
        }
    }
}

// MARK: - AVCapturePhotoCaptureDelegate

extension CaptureSessionManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                             didFinishProcessingPhoto photo: AVCapturePhoto,
                             error: (any Error)?) {
        if let error {
            photoContinuation?.resume(throwing: error)
            photoContinuation = nil
            return
        } else if let cgImage = photo.cgImageRepresentation() {

            let image = UIImage(cgImage: cgImage,
                                scale: 1,
                                orientation: imageOrientation())
            photoContinuation?.resume(returning: image)
            photoContinuation = nil
        }
    }
}
