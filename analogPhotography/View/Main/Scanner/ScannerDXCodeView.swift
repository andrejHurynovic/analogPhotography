//
//  ScannerDXCodeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 6.10.24.
//

import SwiftUI

extension ScannerView {
    struct ScannerDXCodeView: View {
        @ObservedObject var dxCodeBuffer: DXCodeBuffer
        
        var body: some View {
            if let dxCode = dxCodeBuffer.dxCode {
                DXCodeView(dxCode: dxCode)
                    .plainBackgroundStyle()
                    .padding(.horizontal)
                    .aspectRatio(contentMode: .fit)
                CreateFilmCellView(dxCode: dxCode)
                    .plainBackgroundStyle()
            } else {
                Text("No DX codes detected.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .plainBackgroundStyle()
            }
        }
    }
}
