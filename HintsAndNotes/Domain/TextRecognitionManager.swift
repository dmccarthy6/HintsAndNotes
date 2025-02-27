//
//  TextRecognitionManager.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/26/25.
//

import Foundation
import UIKit
import Vision

struct TextRecognitionManager {
    enum TRError: Error {
        case unknown
    }

    func recognizeText(in image: UIImage) async throws {
        guard let cgImage = image.cgImage else {
            return
        }

        let request = try await recognizeTextRequest()
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])

        try requestHandler.perform([request])
    }

    func recognizeTextRequest() async throws -> VNRecognizeTextRequest {
        try await withCheckedThrowingContinuation { continuation in
            let request = VNRecognizeTextRequest { request, error in
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    continuation.resume(throwing: TRError.unknown)
                    return
                }

                observations.forEach { observation in
                    let bestCandidate = observation.topCandidates(1).first?.string
                    print("Found best candidate: \(bestCandidate ?? "NONE")")
                }
            }
            request.recognitionLanguages = ["en"]
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true
            request.minimumTextHeight = 0.4
            continuation.resume(returning: request)
        }
    }
}
