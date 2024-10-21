//
//  ScannerOutputHandler.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 15.10.2024.
//

import Vision
import SwiftUI

actor ScannerOutputHandler {
    //Detectors
    private var detectorsRequests = [VNRequest]()
    private var lastRequestClock = ContinuousClock.now
    //DXCode
    private var capturedImage: CGImage?
    private var lastBarcodeBoundingBox: CGRect?
    private var lastBarcodeSide: CGRect.RelativePosition?
    private var dxCodeCandidatesBuffer = RingBuffer<DXCode>(size: Constants.Scanner.dxCodeBufferSize)
    //Binding
    @MainActor @Binding private var barcode: String?
    @MainActor @Binding private var barcodeBoundingBox: CGRect?
    @MainActor @Binding private var dxCode: DXCode?
    @MainActor @Binding private var dxCodeBoundingBox: CGRect?
    
    init(barcode: Binding<String?>, barcodeBoundingBox: Binding<CGRect?>, dxCode: Binding<DXCode?>, dxCodeBoundingBox: Binding<CGRect?>) {
        self._barcode = barcode
        self._barcodeBoundingBox = barcodeBoundingBox
        self._dxCode = dxCode
        self._dxCodeBoundingBox = dxCodeBoundingBox
        Task {
            await setupDetectorsRequests()
        }
    }
    private func setupDetectorsRequests() async {
        guard let visionModel = try? VNCoreMLModel(for: MLModel(contentsOf: DXCodeDetector.urlOfModelInThisBundle)) else {
            Log.error("Cannon create visionModel.")
            return
        }
        
        detectorsRequests = [VNCoreMLRequest(model: visionModel, completionHandler: visionRequestCompletionHandler),
                             VNDetectBarcodesRequest(completionHandler: visionRequestCompletionHandler)]
    }
    
    //MARK: Extraction
    private func visionRequestCompletionHandler(request: VNRequest, error: Error?) {
        if let error = error {
            Log.error(error.localizedDescription)
        }
        Task {
            switch request {
            case is VNDetectBarcodesRequest:
                await extractBarcodeDetections(request.results)
            case is VNCoreMLRequest:
                await extractDXCodeDetections(request.results)
            default:
                Log.error("Unidentified Vision result.")
            }
        }
    }
    
    private func extractBarcodeDetections(_ results: [VNObservation]?) async {
        guard let results = results as? [VNBarcodeObservation],
              let detectedBarcode = results.first else {
            Task { @MainActor in
                barcodeBoundingBox = nil
            }
            return
        }
        let payloadString = detectedBarcode.payloadStringValue
        let boundingBox = detectedBarcode.boundingBox
        lastBarcodeBoundingBox = boundingBox
        
        Task { @MainActor in
            barcode = payloadString
            barcodeBoundingBox = boundingBox
        }
    }
    
    private func extractDXCodeDetections(_ results: [VNObservation]?) async {
        guard let results = results as? [VNRecognizedObjectObservation],
              let detectedDXCodeObservation = results.first else {
            Task { @MainActor in
                dxCodeBoundingBox = nil
            }
            return
        }
        let boundingBox = detectedDXCodeObservation.boundingBox
        Task { @MainActor in
            dxCodeBoundingBox = boundingBox
        }
        
        let ciImageRect = VNImageRectForNormalizedRect(boundingBox, capturedImage!.width, capturedImage!.height)
        let cgImageRect = CGRect(x: ciImageRect.minX, y: CGFloat(capturedImage!.height) - ciImageRect.maxY, width: ciImageRect.width, height: ciImageRect.height)
        guard let capturedImage = capturedImage,
              let dxCodeImage = capturedImage.cropping(to: cgImageRect) else { return }
        let barcodeSide = lastBarcodeBoundingBox?.relativePosition(to: boundingBox)
        
        await decodeDXCodeImage(image: dxCodeImage)
        lastBarcodeSide = barcodeSide
    }
    
    //MARK: DXCodeDecoding
    
    private func decodeDXCodeImage(image: CGImage) async {
        dxCodeCandidatesBuffer.add(await DXCode(from: image, lastBarcodeSide))
        guard let mostFrequentCandidateDXCode = dxCodeCandidatesBuffer.buffer.mostFrequentElement(),
              mostFrequentCandidateDXCode.percentage >= Constants.Scanner.dxCodeDetectorPrecision else {
            Task { @MainActor in
                dxCode = nil
            }
            return
        }
        Task { @MainActor in
            dxCode = mostFrequentCandidateDXCode.element
        }
    }
    
    //MARK: Video output
    
    public func handleVideoOutput(cgImage: CGImage) {
        guard lastRequestClock.duration(to: .now) > Constants.Scanner.requestDelay else { return }
        
        guard let grayscaleCGImage = grayscaleCGImage(from: cgImage) else { return }
        capturedImage = grayscaleCGImage
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage)
        do {
            try imageRequestHandler.perform(detectorsRequests)
        } catch {
            print(error)
        }
        
        lastRequestClock = .now
    }
    
    private func grayscaleCGImage(from cgImage: CGImage) -> CGImage? {
        let imageWidth = cgImage.width
        let imageHeight = cgImage.height
        guard let cgContext = CGContext(data: nil,
                                width: imageWidth,
                                height: imageHeight,
                                bitsPerComponent: 8,
                                bytesPerRow: imageWidth,
                                space: CGColorSpaceCreateDeviceGray(),
                                bitmapInfo: CGImageAlphaInfo.none.rawValue)
        else { return nil }
        cgContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(imageWidth), height: CGFloat(imageHeight)))
        return cgContext.makeImage()
    }
}
