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
    
    var body: some View {
        List {
            
            Section("Информация") {
                TextFieldFormView(title: "Название:", placeholder: "добавить", text: $camera.name)
            }
            
            Section("Плёнки") {
                Button("Добавить", systemImage: "plus.circle.fill", action: {
                    if camera.films.isEmpty == false {
//                        FilmsView(films: films)
                    }
                })
            }
            
            NoteView(prompt: "Добавить заметку", note: $camera.note)
        }
        .navigationTitle(camera.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar { toolbarMenu }
        
    }
    
    var toolbarMenu: some View {
        Menu("", systemImage: "ellipsis.circle") {
            DeleteButton {
                modelContext.delete(camera)
            }
        }
    }
    
}


#Preview {
    NavigationView {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Camera.self,
                                               configurations: config)
            let previewCamera = Camera(name: "Pentax SFX", note: "Мой личный Pentax SFX", Films: [])
            return CameraDetailedView(camera: previewCamera)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model")
        }
    }
}
