//
//  PlainBackgroundViewModifier.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.10.24.
//

import SwiftUI

fileprivate struct PlainBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 25.0).fill(.background))
            .padding(.horizontal)
    }
}

extension View {
    func plainBackgroundStyle() -> some View {
        modifier(PlainBackgroundViewModifier())
    }
}

