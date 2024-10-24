//
//  DXCodeScannerViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.09.24.
//

import SwiftUI
import AVKit

@MainActor
final class FilmScannerViewModel: ObservableObject {
    @Published var state: FilmScannerState = .cameraAccessNotDetermined
    @Published var menuState: FilmScannerMenuState = .barcode
    
    @Published var dxCode: DXCode?
    @Published var barcode: String?
    
    init() {
        Task { await updateScannerAccessStatus() }
    }
    
    private func updateScannerAccessStatus() async {
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
    
    public func requestCameraPermission() async {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        state = granted ? .scannerAvailable : .cameraAccessDenied
    }
    
}

enum FilmScannerMenuState: Described, CaseIterable {
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


