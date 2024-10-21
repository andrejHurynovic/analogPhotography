//
//  ScannerDelegate.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

import UIKit
import AVFoundation

extension ScannerViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    //MARK: Setup
    func setupDetectorVideoOutput() async {
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "com.analogPhotography.captureSessionQueue"))
        captureSession.addOutput(videoOutput)
    }
    
    //MARK: Capture video output.
    nonisolated func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvImageBuffer: pixelBuffer)
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) else { return }
        Task {
            await outputActor.handleVideoOutput(cgImage: cgImage)
        }
    }
}
