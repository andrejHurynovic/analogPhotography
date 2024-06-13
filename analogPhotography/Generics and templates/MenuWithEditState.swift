//
//  MenuWithEditState.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 13.06.24.
//

import SwiftUI

struct MenuWithEditState<Content: View>: View {
    @Binding var editState: Bool
    
    var content: () -> Content
    
    var body: some View {
        if editState {
            Button("Готово") {
                editState = false
            }
        } else {
            Menu("", systemImage: "ellipsis.circle") {
                Button("Править", systemImage: "pencil") {
                    editState = true
                }
                content()
            }
        }
        
    }
}

#Preview {
    @State var editState: Bool = false
    
    return NavigationStack {
        List {
            EmptyView()
        }
        .toolbar {
            MenuWithEditState(editState: $editState) {
                EmptyView()
            }
        }
    }
    
}
