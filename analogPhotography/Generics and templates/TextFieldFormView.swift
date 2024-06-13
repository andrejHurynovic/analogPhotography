//
//  TextFieldFormView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.06.24.
//

import SwiftUI

struct TextFieldFormView: View {
    var title: String
    var placeholder: String
    
    @Binding var text: String
    @Binding var editState: Bool
    
    @FocusState var focusState: Bool
    
    var foregroundColor: Color { !focusState ? .gray : .primary }
    
    var body: some View {
        FormView(title: title) {
            TextField(placeholder, text: $text, axis: .horizontal)
                .multilineTextAlignment(.trailing)
                .foregroundStyle(foregroundColor)
            
                .onSubmit {
                    editState = false
                }
            
                .focused($focusState)
                .onChange(of: focusState) { _, newValue in
                    editState = newValue
                }
        }
        
    }
}

#Preview {
    @State var text: String = ""
    @State var editState: Bool = true
    
    return List {
        TextFieldFormView(title: "Название",
                          placeholder: "Добавить",
                          text: $text,
                          editState: $editState)
    }
}
