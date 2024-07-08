//
//  TapToAddButton.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 9.07.24.
//

import SwiftUI

struct TapToAddButton: View {
    var action: () -> ()
    
    var body: some View {
        Button("Tap to add") {
            action()
        }
        .foregroundStyle(.gray)
    }
}

#Preview {
    TapToAddButton {
        
    }
}
