//
//  ClearFormButton.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 8.07.24.
//

import SwiftUI

struct ClearFormButton: View {
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.gray)
        }

    }
}

#Preview {
    ClearFormButton { }
}
