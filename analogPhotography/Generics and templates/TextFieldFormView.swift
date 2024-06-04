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
    
    var body: some View {
        FormView(title: title) {
            TextField(placeholder, text: $text, axis: .horizontal)
                .multilineTextAlignment(.trailing)
            
        }
    }
}

#Preview {
    @State var text: String = ""
    
    return TextFieldFormView(title: "Название", placeholder: "добавить", text: $text)
}
