//
//  DXCodeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.09.24.
//

import SwiftUI

struct DXCodeView: View {
    var bits: DXCodeBits
    
    var body: some View {
        HStack(spacing: 0) {
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15)
                .frame(width: 30, height: 50)
                .padding(.top, 15)
                .shadow(radius: 15)
            VStack(spacing: 0) {
                UnevenRoundedRectangle(topLeadingRadius: 15, topTrailingRadius: 15)
                    .padding(.horizontal, 30)
                    .shadow(radius: 15)
                rows
            }
        }
    }
    
    var rows: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                DXCodeBitView(bit: DXCodeBit.metalConstant)
                DXCodeRowView(bits: bits.firstRow)
            }
            HStack(spacing: 0) {
                DXCodeBitView(bit: DXCodeBit.metalConstant)
                DXCodeRowView(bits: bits.secondRow)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0)
            .shadow(radius: 10)
        )
    }
    
}
#Preview {
    ModelPreview { film in
        FilmDetailedView(film: film)
    }
}
