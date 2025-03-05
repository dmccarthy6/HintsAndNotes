//
//  CameraViewRepresentable.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/25/25.
//

import AVKit
import UIKit
import SwiftUI

struct CameraViewRepresentable: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> PreviewLayerView {
        let view = PreviewLayerView(session: session)
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspect
        view.videoPreviewLayer.backgroundColor = UIColor.black.cgColor
        return view
    }

    func updateUIView(_ uiView: PreviewLayerView, context: Context) {
        //
    }

    final class PreviewLayerView: UIView {
        let session: AVCaptureSession
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            guard let captureLayer = layer as? AVCaptureVideoPreviewLayer else {
                return AVCaptureVideoPreviewLayer(session: session)
            }
            return captureLayer
        }

        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }

        init(session: AVCaptureSession) {
            self.session = session
            super.init(frame: .zero)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
