//
//  DXCodeScannerView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.09.24.
//

import SwiftUI
import SwiftData

struct FilmScannerView<FilmType: FilmProtocol>: View {
    @StateObject var viewModel = FilmScannerViewModel()
    @Environment(\.modelContext) private var modelContext
    
    var selectedFilm: Binding<FilmType?>?
    
    var body: some View {
        switch viewModel.state {
        case .cameraAccessNotDetermined:
            FilmScannerContentUnavailableView(description: "Access to the camera is required to read the DX code.",
                                          actionTitle: "Allow access to the camera",
                                          action: { await viewModel.requestCameraPermission() })
        case .cameraAccessDenied:
            FilmScannerContentUnavailableView(description: "Access to the camera is required to read the DX code. You refused earlier, go to settings to allow access to the camera.",
                                          actionTitle: "Allow access to the camera",
                                          action: { UIApplication.openAppSettings() })
        case .cameraNotAvailable:
            FilmScannerContentUnavailableView(description: "Access to the camera is required to read the DX code. The camera is not available on your device.")
        case .scannerAvailable:
            ZStack(alignment: .bottom) {
                ScannerView(barcode: $viewModel.barcode,
                            dxCode: $viewModel.dxCode)
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    bottomMenuStatePicker
                    switch viewModel.menuState {
                    case .barcode:
                        FilmScannerBarcodeView(filterDXBarcode: viewModel.barcode, bottomMenuState: $viewModel.menuState, selectedFilm: selectedFilm, modelContext: modelContext)
                    case .dxCode:
                        FilmScannerDXCodeView(dxCode: viewModel.dxCode, selectedFilm: selectedFilm)
                    }
                }
            }
            .animation(.easeInOut, value: viewModel.barcode)
            .animation(.easeInOut, value: viewModel.dxCode)
        }
    }
    
    var bottomMenuStatePicker: some View {
        Picker("", selection: $viewModel.menuState.animation()) {
            ForEach(FilmScannerMenuState.allCases, id: \.self) { item in
                Text(item.uiDescription)
            }
        }
        .pickerStyle(.palette)
        .plainBackgroundStyle()
        
    }
}
