//
//  FloatingBackgroundViewModifier.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 7.10.24.
//

import SwiftUI

fileprivate struct FloatingBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 25.0).fill(.background))
    }
}
extension View {
    func floatingBackground() -> some View {
        modifier(FloatingBackgroundViewModifier())
    }
}
