//
//  TextFieldForm.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.06.24.
//

import SwiftUI

struct TextFieldForm: View {
    private var title: String
    private var placeholder: String
    private var foregroundColor: Color { isFocused || (isEditing?.wrappedValue ?? false) ? .primary : .gray }
    
    private var isEditing: Binding<Bool>?
    @FocusState private var isFocused: Bool
    
    @StateObject private var viewModel: TextFieldFormViewModel
    
    init(title: String,
         placeholder: String = "Tap to add",
         text: Binding<String>,
         isEditing: Binding<Bool>? = nil,
         resetEditOnSubmit: Bool = true,
         focusOnEdit: Bool = true) {
        self._viewModel = StateObject(wrappedValue:
            TextFieldFormViewModel(text: text, isEditing: isEditing, resetEditOnSubmit: resetEditOnSubmit, focusOnEdit: focusOnEdit))
        self.isEditing = isEditing
        self.title = title
        self.placeholder = placeholder
    }
    
    var body: some View {
        FormView(title: title) {
            textField
            clearFormButton
        }
    }
    
    @ViewBuilder private var textField: some View {
        TextField(placeholder, text: viewModel.text, axis: .horizontal)
            .multilineTextAlignment(.trailing)
            .foregroundStyle(foregroundColor)
            
            .focused($isFocused)
        
            .onChange(of: viewModel.isFocused) { self.isFocused = $1 }
            .onChange(of: self.isFocused) { viewModel.handleFocusChange($1) }
            .onChange(of: isEditing?.wrappedValue) { viewModel.handleIsEditingChange() }
    }
    @ViewBuilder private var clearFormButton: some View {
        if isFocused {
            ClearFormButton { viewModel.handleClear() }
        }
    }
    
}

#Preview {
    struct TextFieldFormViewPreview: View {
        @State var textA: String = ""
        @State var textB: String = ""
        @State var isEditing: Bool = false
        
        var body: some View {
            List {
                Section("With isEditing") {
                    Toggle("isEditing", isOn: $isEditing)
                TextFieldForm(title: "Name",
                              text: $textA,
                              isEditing: $isEditing)
                }
                Section("Without isEditing") {
                TextFieldForm(title: "Name",
                              text: $textB)
                }
            }
        }
    }
    
    return TextFieldFormViewPreview()
}
