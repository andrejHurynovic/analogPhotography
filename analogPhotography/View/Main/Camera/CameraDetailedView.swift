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
    
    init(camera: Camera) {
        self._viewModel = StateObject(wrappedValue: CameraDetailedViewModel(model: camera))
    }
    
    var body: some View {
        List {
            Section("Info") {
                TextFieldForm(title: "Name", text: $viewModel.model.name, viewState: $viewModel.viewState, focusOnEdit: true)
            }
            
            Section("Film rolls") {
                Button("Add", systemImage: "plus.circle.fill", action: {
                    
                })
            }
            
            NoteView(note: $viewModel.model.note)
        }
        .navigationBarBackButtonHidden(viewModel.viewState == .creating)
        .navigationTitle(viewModel.model.name)
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
