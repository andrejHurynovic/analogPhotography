//
//  NoteView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 6.06.24.
//

import SwiftUI

struct NoteView: View {
    @Binding var note: String
    
    var prompt: String = "Add note"
    
    var body: some View {
        Section("Note") {
            TextField(prompt, text: $note, axis: .vertical)
        }
    }
}

#Preview {
    @State var note: String = ""
    
    return NavigationStack {
        List {
            NoteView(note: $note)
        }
    }
}
