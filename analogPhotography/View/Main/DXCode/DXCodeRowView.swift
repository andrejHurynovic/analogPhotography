//
//  DXCodeRowView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 22.09.24.
//

import SwiftUI

struct DXCodeRowView: View {
    @Binding var bits: [DXCodeBit]
    
    var body: some View {
            ForEach(Array(bits.reversed().enumerated()), id: \.offset) { index, bit in
                DXCodeBitView(bit: bit) { _ in
                    print("Processing \(index) that is \(bit)")
                    bits[bits.count - 1 - index].toggle()
                }
            }
    }
}
