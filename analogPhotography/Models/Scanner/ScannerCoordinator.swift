//
//  ScannerCoordinator.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

import SwiftUI

final class ScannerCoordinator: NSObject {
    @Binding private var barcodes: Set<String>
    private var dxCodeBuffer: DXCodeBuffer
    
    init(barcodes: Binding<Set<String>>, dxCodeBuffer: DXCodeBuffer) {
        self._barcodes = barcodes
        self.dxCodeBuffer = dxCodeBuffer
    }
    
    func addBarcodes(_ barcodes: [String]) {
        self.barcodes.formUnion(barcodes)
    }
    func addDXCodeImage(image: CGImage, barcodeSide: CGRect.RelativePosition?) {
        self.dxCodeBuffer.addDXCodeImage(cgImage: image, barcodeSide: barcodeSide)
    }
}
