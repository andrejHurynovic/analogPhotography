//
//  DXCodeRowView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 22.09.24.
//

import SwiftUI

struct DXCodeRowView: View {
    var bits: [DXCodeBit]
    
    var body: some View {
        HStack(spacing: 0) {
            DXCodeBitView(bit: DXCodeBit.metalConstant)
            ForEach(bits, id: \.hashValue) { bit in
                DXCodeBitView(bit: bit)
            }
        }
    }
}
