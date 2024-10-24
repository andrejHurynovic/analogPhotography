//
//  DXCodeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.09.24.
//

import SwiftUI

struct DXCodeView: View {
    var dxCode: DXCode
    
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
            DXCodeRowView(bits: dxCode.firstRow)
            DXCodeRowView(bits: dxCode.secondRow)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0)
            .shadow(radius: 10)
        )
    }
    
}
#Preview {
    ModelPreview { film in
        FilmDetailedView(film: film as Film)
    }
}
