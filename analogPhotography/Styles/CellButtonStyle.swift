//
//  CellButtonStyle.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 18.10.2024.
//

import SwiftUI

struct CellButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.callout)
            .bold()
            .padding(.horizontal, 24)
            .padding(.vertical, 6)
            .background(.tint)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
