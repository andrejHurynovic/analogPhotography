//
//  NoteView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 6.06.24.
//

import SwiftUI

struct NoteView: View {
    let prompt: String
    @Binding var note: String
    
    var body: some View {
        Section("Заметки") {
            TextField(prompt, text: $note, axis: .vertical)
        }
    }
}

#Preview {
    @State var note: String = ""
    
    return NavigationStack {
        List {
            NoteView(prompt: "Добавить замтетку", note: $note)
        }
    }
}
