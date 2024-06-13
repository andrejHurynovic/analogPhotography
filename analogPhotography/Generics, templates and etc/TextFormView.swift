//
//  TextFormView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.06.24.
//

import SwiftUI

struct TextFormView: View  {
    var title: String
    var text: String?
    
    init(_ title: String, _ text: String?) {
        self.title = title
        self.text = text
    }
    
    var body: some View {
        if let text = text {
            FormView(title: title) {
                Text(text)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    TextFormView("ISO", "300")
}
