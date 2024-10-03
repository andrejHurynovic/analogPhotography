//
//  DXCodeScannerViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.09.24.
//

import SwiftUI
import AVKit
import VisionKit

@MainActor
final class ScannerViewModel: ObservableObject {
    @Published var state: DXCodeScannerState = .cameraAccessNotDetermined
    @Published var recognisedItems: [RecognizedItem] = []
    
    init() {
        Task { await updateScannerAccessStatus() }
    }
    
    func updateScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            state = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            self.state = .cameraAccessNotDetermined
        case .authorized:
            self.state = .scannerAvailable
        case .denied, .restricted:
            self.state = .cameraAccessDenied
        @unknown default: break
        }
    }
    
    func requestCameraPermission() async {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        state = granted ? .scannerAvailable : .cameraAccessDenied
    }
    
}
