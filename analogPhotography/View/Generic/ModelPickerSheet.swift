//
//  ModelPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 7.10.24.
//

import SwiftUI
import SwiftData

struct ModelPickerSheet<Element: PersistentModel, Content: View>: View {
    @Binding var isPresented: Bool
    
    @Binding var selectedElement: Element?
    var elements: [Element]
    var buttonContent: (() -> Content)?
    var modelContent: (Element) -> Content

    var body: some View {
        List(elements) { element in
            Button {
                withAnimation {
                    selectedElement = element
                }
                isPresented = false
            } label: {
                modelContent(element)
            }
            .buttonStyle(.plain)
        }
    }

}
