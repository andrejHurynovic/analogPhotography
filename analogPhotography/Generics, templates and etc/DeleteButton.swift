//
//  DeleteButton.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.06.24.
//

import SwiftUI

struct DeleteButton: View {
    var action: () -> ()
    
    var body: some View {
        Button(role: .destructive) {
            action()
        } label: {
            Button("Удалить", systemImage: "trash", role: .destructive) {
                action()
            }
        }
    }
}

#Preview {
    DeleteButton(action: {})
}
