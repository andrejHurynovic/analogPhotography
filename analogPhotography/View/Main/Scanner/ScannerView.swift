//
//  DXCodeScannerView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.09.24.
//

import SwiftUI

struct ScannerView: View {
    @StateObject var viewModel = ScannerViewModel()
    @StateObject var dxCodeBuffer = DXCodeBuffer()
    
    @State var barcodes = Set<String>()
    
    @AppStorage("cropCorrectionModifier") var cropCorrectionModifier: Double = 0.1
    @AppStorage("calculateThresholdModifier") var calculateThresholdModifier: Double = 0.8
    @AppStorage("heightRangeModifier") var heightRangeModifier: Double = 0.1
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .cameraAccessNotDetermined:
                ScannerContentUnavailableView(description: "Access to the camera is required to read the DX code.",
                                              actionTitle: "Allow access to the camera",
                                              action: { await viewModel.requestCameraPermission() })
            case .cameraAccessDenied:
                ScannerContentUnavailableView(description: "Access to the camera is required to read the DX code. You refused earlier, go to settings to allow access to the camera.",
                                              actionTitle: "Allow access to the camera",
                                              action: { UIApplication.openAppSettings() })
            case .cameraNotAvailable:
                ScannerContentUnavailableView(description: "Access to the camera is required to read the DX code. The camera is not available on your device.")
            case .scannerAvailable:
                    ScannerViewControllerRepresentable(barcodes: $barcodes, dxCodeBuffer: dxCodeBuffer)
            }
            
        }
    }
}

#Preview {
    ScannerView()
}
