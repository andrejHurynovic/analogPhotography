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
        
        func handleSubmit() {
            guard let viewState = self.viewState,
                  viewState.wrappedValue == .editing else { return }
            viewState.wrappedValue = .showing
        }
        
        func handleFocusChange(_ isFocused: Bool) {
            self.isFocused = isFocused
            
            guard let viewState = self.viewState,
                  viewState.wrappedValue == .showing,
                  isFocused == true else { return }
            viewState.wrappedValue = .editing
        }
        func handleViewStateChange() {
            guard let viewState = self.viewState?.wrappedValue else { return }
            if focusOnEdit && isFocused == false {
                isFocused = true
                return
            }
            if viewState == .showing {
                isFocused = false
                return 
            }
        }
        
        func handleClear() {
            text.wrappedValue = ""
        }
        
    }
}
