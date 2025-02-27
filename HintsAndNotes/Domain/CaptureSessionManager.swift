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
            return // TODO: Throw here
        }
        let input = try AVCaptureDeviceInput(device: device)

        if session.canAddInput(input) {
            session.addInput(input)
        } else {
            print("CAN NOT ADD INPUTS")
            // TODO: Throw
        }
    }

    private func addOutputs() throws {
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        } else {
            print("CAN NOT ADD OUTPUTS")
            // TODO: Throw error
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
        let settings = AVCapturePhotoSettings()

        if let previewPhotoPixelFormatType = settings.availablePreviewPhotoPixelFormatTypes.first {
            settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPhotoPixelFormatType]
        }
        return settings
    }
}

extension CaptureSessionManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                             didFinishProcessingPhoto photo: AVCapturePhoto,
                             error: (any Error)?) {
        if let error {
            photoContinuation?.resume(throwing: error)
            photoContinuation = nil
            return
        } else if let cgImage = photo.cgImageRepresentation(),
                  let orientationInt = photo.metadata[String(kCGImagePropertyOrientation)] as? UInt32,
                  let imageOrientation = UIImage.Orientation.orientation(from: orientationInt) {

            let image = UIImage(cgImage: cgImage,
                                scale: 1,
                                orientation: imageOrientation)
            photoContinuation?.resume(returning: image)
            photoContinuation = nil
        }
    }
}

private extension UIImage.Orientation {
    init(_ cgOrientation: CGImagePropertyOrientation) {
        switch cgOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .leftMirrored: self = .leftMirrored
        case .right: self = .rightMirrored
        case .rightMirrored: self = .rightMirrored
        case .left: self = .left
        }
        HNLog.debug(category: .captureSession,
                    message: "Image orientation is: \(cgOrientation)")
    }

    static func orientation(from orientationRaw: UInt32) -> UIImage.Orientation? {
        var orientation: UIImage.Orientation?

        if let cgOrientation = CGImagePropertyOrientation(rawValue: orientationRaw) {
            orientation = UIImage.Orientation(cgOrientation)
        } else {
            HNLog.debug(category: .captureSession, message: "Orientation is nil")
            orientation = nil
        }
        return orientation
    }
}
