//
//  CaptureSessionManager.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/24/25.
//

import AVKit

struct CaptureSessionManager {
    let session = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: "com.dylanmccarthy.capturesessionqueue")

    private var deviceTypes: [AVCaptureDevice.DeviceType] {
        [
            .builtInTrueDepthCamera,
            .builtInDualCamera,
            .builtInWideAngleCamera
        ]
    }

    func configureCaptureSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo
        // TODO: FIX
        try? self.setupVideoInputs()
        // photo output
        // commit config
        // start capturing
    }

    func bestDeviceAt(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
                                                       mediaType: .video,
                                                       position: position)
        return session.devices.first(where: { $0.position ==  position})
    }

    func setupVideoInputs() throws {
        guard let device = bestDeviceAt(position: .back) else {
#warning("TODO: Throw error, remove fatalError")
            fatalError("No capture device")
        }

        let input = try AVCaptureDeviceInput(device: device)

        if session.canAddInput(input) {
            session.addInput(input)
        } else {
#warning("TODO: Throw error, remove fatalError")
            fatalError("Session could not add inputs")
            // Error
        }
    }

    func setOutputs() {

    }

    func startCapturing() {
        // TODO: Make sure all worked before we start running
        session.startRunning()
    }

    func stopCapturing() {
        session.stopRunning()
    }
}
