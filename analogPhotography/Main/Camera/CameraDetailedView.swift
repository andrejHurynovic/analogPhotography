//
//  CameraDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI
import SwiftData

struct CameraDetailedView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var camera: Camera
    @State var editState: Bool = false
    
    var body: some View {
        List {
            
            Section("Информация") {
                TextFieldFormView(title: "Название", setFocusStateToTrueOnEditStateTrue: true, text: $camera.name, editState: $editState)
            }
            
            Section("Плёнки") {
                Button("Добавить", systemImage: "plus.circle.fill", action: {
                    if camera.filmRolls.isEmpty == false {
//                        FilmsView(rolls: filmRolls)
                    }
                })
            }
            
            NoteView(prompt: "Добавить заметку", note: $camera.note)
        }
        .navigationTitle(camera.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar { toolbarMenu }
        
    }
    
    @ViewBuilder var toolbarMenu: some View {
        MenuWithEditState(editState: $editState) {
            DeleteButton {
                modelContext.delete(camera)
            }
        }
        
    }
    
}

#Preview {
    ModelPreview { camera in
        CameraDetailedView(camera: camera)
    }
}
