//
//  FloatingSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 28.10.2024.
//

import SwiftUI

extension View {
    @ViewBuilder func floatingSheet<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        self.sheet(isPresented: isPresented) {
            content()
                .presentationCornerRadius(0)
                .presentationBackground(.clear)
                .presentationBackgroundInteraction(.enabled)
                .presentationDragIndicator(.hidden)
        }
    }
}
