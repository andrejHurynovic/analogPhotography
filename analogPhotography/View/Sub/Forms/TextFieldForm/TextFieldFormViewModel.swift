//
//  TextFieldFormViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 9.07.24.
//

import SwiftUI
import Combine

extension TextFieldForm {
    final class TextFieldFormViewModel: ObservableObject {
        var text: Binding<String>
        private var viewState: Binding<ViewState>?
        
        private var resetEditOnSubmit: Bool
        private var focusOnEdit: Bool
        
        @Published var isFocused: Bool = false
                
        init(text: Binding<String>, viewState: Binding<ViewState>? = nil, resetEditOnSubmit: Bool , focusOnEdit: Bool) {
            self.text = text
            self.resetEditOnSubmit = resetEditOnSubmit
            self.focusOnEdit = focusOnEdit
            self.viewState = viewState
        }
        
        func handleFocusChange(_ isFocused: Bool) {
            self.isFocused = isFocused
            
            guard let viewState = self.viewState,
                  viewState.wrappedValue != .creating else { return }
            viewState.wrappedValue = isFocused ? .editing : .showing
        }
        func handleIsEditingChange() {
            guard let viewState = self.viewState?.wrappedValue else { return }
            isFocused = viewState.editingAvailable && focusOnEdit
        }
        
        func handleClear() {
            text.wrappedValue = ""
        }
        
    }
}
