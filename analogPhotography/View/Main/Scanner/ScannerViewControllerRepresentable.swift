//
//  ScannerViewControllerRepresentable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 30.09.24.
//

import SwiftUI

struct ScannerViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var barcodes: Set<String>
    var dxCodeBuffer: DXCodeBuffer
    
    func makeCoordinator() -> ScannerCoordinator {
        return ScannerCoordinator(barcodes: $barcodes, dxCodeBuffer: dxCodeBuffer)
    }
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ScannerViewController()
        viewController.coordinator = context.coordinator
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}
