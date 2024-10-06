//
//  BackgroundViewModifier.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.10.24.
//

import SwiftUI

fileprivate struct BackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 25.0).fill(.bar))
            .padding()
    }
}

extension View {
    func backgroundStyle() -> some View {
        modifier(BackgroundViewModifier())
    }
}
