//
//  CameraDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI


struct CameraDetailedView: View {
    @StateObject private var viewModel: CameraDetailedViewModel
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var router: AppRouter
    
    init(camera: Camera?) {
        self._viewModel = StateObject(wrappedValue: CameraDetailedViewModel(camera: camera))
    }
    
    var body: some View {
        List {
            Button("Nigga") {
                router.navigate(to: .camera(viewModel.camera))
            }
            Button("Nigga II") {
                print(router.path)
            }
            Section("Info") {
                TextFieldForm(title: "Name", text: $viewModel.camera.name, viewState: $viewModel.viewState, focusOnEdit: true)
            }
            
            Section("Films") {
                Button("Add", systemImage: "plus.circle.fill", action: {
                    if viewModel.camera.filmRolls.isEmpty == false {
//                        FilmRollsView(rolls: filmRolls)
                    }
                })
            }
            
            NoteView(note: $viewModel.camera.note)
        }
        .navigationBarBackButtonHidden(viewModel.viewState == .creating)
        .navigationTitle(viewModel.camera.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar { toolbarContent }
        
    }
    
    private var toolbarContent: some ToolbarContent {
        ViewStateToolbar(viewState: $viewModel.viewState) { EmptyView() }
    createAction: { viewModel.insert(in: modelContext) }
    deleteAction: { viewModel.delete(in: modelContext) }
    }
    
}

#Preview {
    ModelPreview { camera in
        CameraDetailedView(camera: camera)
    }
}
