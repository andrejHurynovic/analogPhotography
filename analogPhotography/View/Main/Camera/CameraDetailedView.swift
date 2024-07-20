//
//  CameraDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI

struct CameraDetailedView: View {
    @Bindable var camera: Camera
    
    var body: some View {
        DetailedView(model: camera, viewModelType: CameraDetailedViewModel.self) { viewModel, viewModelBinding  in
            List {
                Section("Info") {
                    TextFieldForm(title: "Name", text: viewModelBinding.model.name, viewState: viewModelBinding.viewState, focusOnEdit: true)
                }
                Section("Film rolls") {
                    Button("Add", systemImage: "plus.circle.fill", action: { })
                }
                
                NoteView(note: viewModelBinding.model.note)
            }
        }
    }
}

#Preview {
    ModelPreview { camera in
        CameraDetailedView(camera: camera)
    }
}
