//
//  FormView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.06.24.
//

import SwiftUI

struct FormView<Content: View>: View  {
    var title: String
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            content()
        }
    }
}


#Preview {
    FormView(title: "ISO") {
        Text("300")
    }
}

