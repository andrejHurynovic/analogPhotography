//
//  DXCodeScannerViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.09.24.
//

import SwiftUI
import AVKit

@MainActor
final class ScannerViewModel: ObservableObject {
    @Published var state: DXCodeScannerState = .cameraAccessNotDetermined
    @Published var bottomMenuState: ScannerViewBottomMenuState = .dxCode
    
    @Published var dxCodeBuffer = DXCodeBuffer()
    @Published var barcodes = Set<String>()
    
    
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

enum ScannerViewBottomMenuState: Described, CaseIterable {
    case barcode
    case dxCode
    
    var uiDescription: String {
        switch self {
        case .barcode:
            "Barcode"
        case .dxCode:
            "DX code"
        }
    }
}


