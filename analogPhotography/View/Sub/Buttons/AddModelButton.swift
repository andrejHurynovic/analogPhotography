//
//  AddModelButton.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 25.07.24.
//

import SwiftUI

struct AddModelButton: View {
    var action: () -> ()
    
    var body: some View {
        Button("Add", systemImage: "plus.circle.fill") { action() }
    }
}

#Preview {
    AddModelButton { }
}
