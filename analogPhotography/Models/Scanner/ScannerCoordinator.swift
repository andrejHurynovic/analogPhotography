//
//  ScannerCoordinator.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

import SwiftUI

final class ScannerCoordinator: NSObject {
    @Binding private var barcode: String
    private var dxCodeBuffer: DXCodeBuffer
    
    init(barcode: Binding<String>, dxCodeBuffer: DXCodeBuffer) {
        self._barcode = barcode
        self.dxCodeBuffer = dxCodeBuffer
    }
    
    func updateBarcode(_ barcode: String) {
        self.barcode = barcode
    }
    func addDXCodeImage(image: CGImage, barcodeSide: CGRect.RelativePosition?) {
        self.dxCodeBuffer.addDXCodeImage(cgImage: image, barcodeSide: barcodeSide)
    }
}
