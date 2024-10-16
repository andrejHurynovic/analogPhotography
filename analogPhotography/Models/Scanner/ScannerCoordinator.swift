//
//  ScannerCoordinator.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

import SwiftUI

final class ScannerCoordinator: NSObject {
    public let scannerOutputActor: ScannerOutputActor
    
    init(barcode: Binding<String?>, barcodeBoundingBox: Binding<CGRect?>, dxCode: Binding<DXCode?>, dxCodeBoundingBox: Binding<CGRect?>) {
        self.scannerOutputActor = ScannerOutputActor(barcode: barcode, barcodeBoundingBox: barcodeBoundingBox, dxCode: dxCode, dxCodeBoundingBox: dxCodeBoundingBox)
    }
}
