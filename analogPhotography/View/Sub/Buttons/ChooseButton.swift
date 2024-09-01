//
//  SelectButton.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 1.09.24.
//

import SwiftUI

struct SelectButton: View {
    var systemImage: String = "plus.circle.fill"
    var action: () -> ()
    
    var body: some View {
        Button("Select", systemImage: systemImage) { action() }
    }
}

#Preview {
    SelectButton(systemImage: "camera", action: { })
}
