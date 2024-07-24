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
    private var text: Binding<String>
    private var foregroundColor: Color { return isFocused || viewState?.wrappedValue.editingAvailable ?? false ? .primary : .gray }
    
    private var viewState: Binding<ViewState>?
    @FocusState private var isFocused: Bool
    
    @StateObject private var viewModel: TextFieldFormViewModel
    
    init(title: String,
         placeholder: String = "Tap to add",
         text: Binding<String>,
         viewState: Binding<ViewState>? = nil,
         resetEditOnSubmit: Bool = true,
         focusOnEdit: Bool = false) {
        self._viewModel = StateObject(wrappedValue:
            TextFieldFormViewModel(text: text, viewState: viewState, resetEditOnSubmit: resetEditOnSubmit, focusOnEdit: focusOnEdit))
        self.viewState = viewState
        self.title = title
        self.placeholder = placeholder
        self.text = text
    }
    
    var body: some View {
        LabeledContent(title) {
            textField
            clearFormButton
        }
    }
    
    @ViewBuilder private var textField: some View {
        TextField(placeholder, text: text, axis: .horizontal)
            .multilineTextAlignment(.trailing)
            .foregroundStyle(foregroundColor)
            
            .focused($isFocused)
        
            .onSubmit { viewModel.handleSubmit() }
            .onChange(of: viewModel.isFocused) { self.isFocused = $1 }
            .onChange(of: self.isFocused) { viewModel.handleFocusChange($1) }
            .onChange(of: viewState?.wrappedValue) { viewModel.handleViewStateChange() }
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
        @State var textC: String? = nil
        @State var viewState: ViewState = .showing
        
        var body: some View {
            NavigationStack {
                Form {
                    Section("With ViewState") {
                        TextForm("State", "\(viewState)")
                        TextFieldForm(title: "Name",
                                      text: $textA,
                                      viewState: $viewState)
                    }
                    Section("Without ViewState") {
                        TextFieldForm(title: "Name",
                                      text: $textB)
                    }
                    Section("Optional") {
                        LabeledContent("Text", value: (String(describing: textC)))
                        TextFieldForm(title: "Name",
                                      text: $textC.unwrappedOptional())
                    }
                }
            }
        }
    }
    
    return TextFieldFormViewPreview()
}
