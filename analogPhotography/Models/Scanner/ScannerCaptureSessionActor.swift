//
//  ScannerCaptureSessionActor.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 15.10.2024.
//

import AVFoundation
import SwiftUI

actor ScannerCaptureSessionActor {
    private let captureSession: AVCaptureSession
    private var isRunning: Bool = false
    private let captureSessionQueue = DispatchQueue(label: "captureSessionQueue")
    
    init(captureSession: AVCaptureSession) {
        self.captureSession = captureSession
    }
    
    public func setupCaptureSession() async {
        guard let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first,
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else { return }
        
        captureSession.addInput(videoDeviceInput)
    }
    
    public func startCaptureSession() async {
        guard !isRunning else { return }
        captureSession.startRunning()
        isRunning = true
    }
    public func stopCaptureSession() async {
        guard isRunning else { return }
        captureSession.stopRunning()
        isRunning = false
    }
}
