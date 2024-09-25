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
        ForEach(bits, id: \.self) { bit in
            DXCodeBitView(bit: bit)
        }
    }
}
