//
//  TextFieldWithPrefix.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 13.06.24.
//

import SwiftUI

private struct TextFieldWithPrefix: ViewModifier {
    var prefix: String
    @Binding var text: String
    @Binding var innerText: String
    
    init(prefix: String, text: Binding<String>, innerText: Binding<String>) {
        self.prefix = prefix
        self._text = text
        
        if !text.wrappedValue.isEmpty {
            self.innerText = prefix + text.wrappedValue
        }
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: innerText) { _, newValue in
                guard !newValue.isEmpty else {
                    text = ""
                    return
                }
                text = innerText.trimmingPrefix(prefix)
                guard text != "" else {
                    innerText = ""
                    return
                }
                innerText = prefix + text
            }
    }
}

extension View {
    func textFieldPrefix(prefix: String, text: Binding<String>, textFieldText: Binding<String>) -> some View {
        self.modifier(TextFieldWithPrefix(prefix: prefix, text: text, innerText: textFieldText))
    }
}
