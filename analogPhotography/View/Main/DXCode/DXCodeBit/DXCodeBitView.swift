//
//  DXCodeBitView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 22.09.24.
//

import SwiftUI

struct DXCodeBitView: View {
    var bit: DXCodeBit
    
    var color: Color {
        switch bit {
        case .paint:
            return .black
        case .metal, .metalConstant:
            return .white
        case .unknown:
            return .yellow
        }
    }
    
    var body: some View {
        Rectangle()
            .fill(color)
            .aspectRatio(0.6, contentMode: .fill)
            .overlay {
                switch bit {
                case .unknown:
                    Image(systemName: "questionmark.circle")
                case .metalConstant:
                    Image(systemName: "lock.circle")
                default:
                    EmptyView()
                }
            }

    }
}
