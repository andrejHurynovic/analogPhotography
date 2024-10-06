//
//  ScannerDetector.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

import UIKit
import AVFoundation
import Vision

extension ScannerViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    //MARK: Setup
    func setupDetectorVideoOutput() {
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "scannerSampleBufferQueue"))
        captureSession.addOutput(videoOutput)
    }
    func setupDetectorBoxesLayer() {
        Task { @MainActor in
            detectionBoxesLayer.frame.size = viewSize
            self.view.layer.addSublayer(detectionBoxesLayer)
        }
    }
    func setupDetectorsRequests() {
        guard let visionModel = try? VNCoreMLModel(for: MLModel(contentsOf: DXCodeDetector.urlOfModelInThisBundle)) else {
            Log.error("Cannon create visionModel.")
            return
        }
        
        self.detectorsRequests = [VNCoreMLRequest(model: visionModel, completionHandler: visionRequestCompletionHandler),
                                  VNDetectBarcodesRequest(completionHandler: visionRequestCompletionHandler)]
    }
    
    //MARK: Extraction
    func visionRequestCompletionHandler(request: VNRequest, error: Error?) {
        if let error = error {
            Log.warning(error.localizedDescription)
        }
        Task {
            switch request {
            case is VNDetectBarcodesRequest:
                extractBarcodeDetections(request.results)
                updateDetectionBoxesLayer()
                
            case is VNCoreMLRequest:
                extractDXCodeDetections(request.results)
                updateDetectionBoxesLayer()
            default:
                updateDetectionBoxesLayer()
                Log.error("Unidentified Vision result.")
            }
        }
    }
    
    func extractBarcodeDetections(_ results: [VNObservation]?) {
        barcodeBoxes = []
        guard let results = results as? [VNBarcodeObservation],
              results.count != 0 else { return }
        
        coordinator.updateBarcode(results[0].payloadStringValue!)
        barcodeBoxes.append(contentsOf: results.map { $0.boundingBox })
    }
    
    func extractDXCodeDetections(_ results: [VNObservation]?) {
        dxCodeBoxes = []
        guard let results = results as? [VNRecognizedObjectObservation],
              results.count != 0 else { return }
        
        let ciImage = CIImage(cvImageBuffer: capturedImage)
        let ciContext = CIContext()
        
        let dxCodesCGImages : [CGImage] = results.compactMap {
            ciContext.createCGImage(ciImage,
                                    from: VNImageRectForNormalizedRect($0.boundingBox, Int(ciImage.extent.width), Int(ciImage.extent.height)))
        }
        dxCodeBoxes.append(contentsOf: results.map { $0.boundingBox })
        
        let barcodeSide = barcodeBoxes.first?.relativePosition(to: dxCodeBoxes.first!)
        
        coordinator.addDXCodeImage(image: dxCodesCGImages.first!, barcodeSide: barcodeSide ?? previousBarcodeSide)
        previousBarcodeSide = barcodeSide
    }
    
    //MARK: Detection boxes
    func updateDetectionBoxesLayer() {
        let layers = (barcodeBoxes + dxCodeBoxes).map { drawDetectionBox($0) }
        Task { @MainActor in
            UIView.animate(withDuration: 0.3) {
                self.detectionBoxesLayer.sublayers = nil
                for layer in layers {
                    self.detectionBoxesLayer.addSublayer(layer)
                }
            }
        }
    }
    
    func drawDetectionBox(_ boundingBox: CGRect) -> CALayer {
        let normalizedObjectBounds = VNImageRectForNormalizedRect(boundingBox, Int(viewSize.width), Int(viewSize.height))
        let boxFrame = CGRect(x: normalizedObjectBounds.minX,
                              y: viewSize.height - normalizedObjectBounds.maxY,
                              width: normalizedObjectBounds.maxX - normalizedObjectBounds.minX,
                              height: normalizedObjectBounds.maxY - normalizedObjectBounds.minY)
        
        let boxLayer = CALayer()
        boxLayer.frame = boxFrame
        boxLayer.borderWidth = 3.0
        boxLayer.borderColor = UIColor.systemYellow.cgColor
        boxLayer.cornerRadius = 8
        return boxLayer
    }
    
    //MARK: Capture video output.
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard previousCaptureOutputClock.duration(to: .now) > Constants.Scanner.captureDelay,
              let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        self.capturedImage = pixelBuffer
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        
        do {
            try imageRequestHandler.perform(self.detectorsRequests)
        } catch {
            print(error)
        }
    }
}

