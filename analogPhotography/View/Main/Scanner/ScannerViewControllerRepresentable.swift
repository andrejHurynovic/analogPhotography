//
//  ScannerViewControllerRepresentable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 30.09.24.
//

import SwiftUI

struct ScannerViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var barcode: String?
    @Binding var barcodeBoundingBox: CGRect?
    @Binding var dxCode: DXCode?
    @Binding var dxCodeBoundingBox: CGRect?
    var viewSize: CGSize
    
    func makeCoordinator() -> ScannerCoordinator {
        return ScannerCoordinator(barcode: $barcode, barcodeBoundingBox: $barcodeBoundingBox, dxCode: $dxCode, dxCodeBoundingBox: $dxCodeBoundingBox)
    }
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ScannerViewController()
        viewController.outputActor = context.coordinator.scannerOutputActor
        viewController.viewSize = viewSize
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}
