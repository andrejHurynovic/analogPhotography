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
        private var isEditing: Binding<Bool>?
        
        private var resetEditOnSubmit: Bool
        private var focusOnEdit: Bool
        
        @Published var isFocused: Bool = false
                
        init(text: Binding<String>, isEditing: Binding<Bool>? = nil, resetEditOnSubmit: Bool , focusOnEdit: Bool) {
            self.text = text
            self.resetEditOnSubmit = resetEditOnSubmit
            self.focusOnEdit = focusOnEdit
            self.isEditing = isEditing
        }
        
        func handleFocusChange(_ isFocused: Bool) {
            self.isFocused = isFocused
            
            guard let isEditing = self.isEditing else { return }
            isEditing.wrappedValue = isFocused
        }
        func handleIsEditingChange() {
            guard let isEditing = self.isEditing?.wrappedValue else { return }
            isFocused = isEditing && focusOnEdit
        }
        
        func handleClear() {
            text.wrappedValue = ""
        }
        
    }
}
