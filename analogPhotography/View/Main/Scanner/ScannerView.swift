//
//  ScannerView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 16.10.2024.
//

import SwiftUI
import Vision

struct ScannerView: View {
    @Binding var barcode: String?
    @State var barcodeBoundingBox: CGRect?
    @Binding var dxCode: DXCode?
    @State var dxCodeBoundingBox: CGRect?
    
    var body: some View {
        ZStack {
            ScannerViewControllerRepresentable(barcode: $barcode,
                                               barcodeBoundingBox: $barcodeBoundingBox,
                                               dxCode: $dxCode,
                                               dxCodeBoundingBox: $dxCodeBoundingBox,
                                               viewSize: UIScreen.main.bounds.size)
            ZStack {
                GeometryReader { geometryProxy in
                    if let barcodeBoundingBox = barcodeBoundingBox {
                        transformedBoundingBox(barcodeBoundingBox, viewSize: geometryProxy.size)
                    }
                    if let dxCodeBoundingBox = dxCodeBoundingBox {
                        transformedBoundingBox(dxCodeBoundingBox, viewSize: geometryProxy.size)
                    }
                }
            }
        }
        .animation(.bouncy, value: barcodeBoundingBox)
        .animation(.bouncy, value: dxCodeBoundingBox)
    }
    
    @ViewBuilder func transformedBoundingBox(_ boundingBox: CGRect, viewSize: CGSize) -> some View {
        let rect = CGRect(x:        boundingBox.minX * viewSize.width,
                          y:        viewSize.height - boundingBox.minY * viewSize.height,
                          width:    boundingBox.width * viewSize.width,
                          height:   boundingBox.height * viewSize.height)
        
        RoundedBoundingBox(cornerRadius: 4, lineLength: 12)
            .stroke(Color.yellow, lineWidth: 2)
            .position(x: rect.midX, y: rect.midY)
            .frame(width: rect.width, height: rect.height)
    }
}
