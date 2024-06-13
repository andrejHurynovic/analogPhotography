//
//  TextFieldFormView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.06.24.
//

import SwiftUI

struct TextFieldFormView: View {
    var title: String
    var placeholder: String = "Добавить"
    var setEditStateToFalseOnSubmit: Bool = false
    var setFocusStateToTrueOnEditStateTrue = false
    
    @Binding var text: String
    @Binding var editState: Bool
    
    @FocusState var focusState: Bool
    
    var foregroundColor: Color { focusState || editState ? .primary : .gray }
    
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
                .onChange(of: editState) { _, newValue in
                    if newValue == false && focusState == true {
                        focusState = false
                    }
                    if setFocusStateToTrueOnEditStateTrue && newValue == true && focusState == false {
                        focusState = true
                    }
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
