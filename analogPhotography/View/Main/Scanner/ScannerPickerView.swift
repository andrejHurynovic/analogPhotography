//
//  DXCodeScannerView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.09.24.
//

import SwiftUI
import SwiftData

struct ScannerPickerView: View {
    @StateObject var viewModel = ScannerPickerViewModel()
    @Environment(\.modelContext) private var modelContext
    
    @State var barcodeBoundingBox: CGRect?
    @State var dxCodeBoundingBox: CGRect?
    
    var body: some View {
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
            ZStack(alignment: .bottom) {
                ScannerView(barcode: $viewModel.barcode,
                            dxCode: $viewModel.dxCode)
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    bottomMenuStatePicker
                    switch viewModel.bottomMenuState {
                    case .barcode:
                        ScannerBarcodeView(filterDXBarcode: viewModel.barcode, modelContext: modelContext)
                    case .dxCode:
                        ScannerDXCodeView(dxCode: viewModel.dxCode)
                    }
                }
            }
            .animation(.easeInOut, value: viewModel.barcode)
            .animation(.easeInOut, value: viewModel.dxCode)
        }
    }
    
    var bottomMenuStatePicker: some View {
        Picker("", selection: $viewModel.bottomMenuState.animation()) {
            ForEach(ScannerViewBottomMenuState.allCases, id: \.self) { item in
                Text(item.uiDescription)
            }
        }
        .pickerStyle(.palette)
        .plainBackgroundStyle()
        
    }
}

#Preview {
    RoutedNavigationStack {
        ScannerPickerView()
    }
}
