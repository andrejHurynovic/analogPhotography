//
//  CameraDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI

struct CameraDetailedView: View {
    @Bindable var camera: Camera
    var selectedCamera: Binding<Camera?>?
    
    var body: some View {
        DetailedView(model: camera,
                     selectedModel: selectedCamera,
                     viewModelType: CameraDetailedViewModel.self) { viewModel, viewModelBinding in
            Form {
                if viewModel.viewState.editingAvailable {
                    Section("Info") {
                        TextFieldForm(title: "Name", text: viewModelBinding.model.name, viewState: viewModelBinding.viewState, focusOnEdit: true)
                    }
                    NoteView(note: viewModelBinding.model.note)
                } else {
                    Button {
                        viewModel.viewState = .editing
                    } label: {
                        CameraMinimizedView(camera: camera)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Section("Current film roll") {
                    CameraFilmRollView(camera: camera)
                }
                currentFilmRollPhotos
                finishedFilmRolls
            }
            .animation(.default, value: viewModel.viewState)
        }
    }
    
    @ViewBuilder var currentFilmRollPhotos: some View {
        if let currentFilmRoll = camera.currentFilmRoll {
            Section("Current film rolls photos") {
                ForEach(currentFilmRoll.photos) { photo in
                    PhotoView(photo: photo)
                }
            }
        }
    }
    
    @ViewBuilder var finishedFilmRolls: some View {
        if let finishedFilmRolls = camera.finishedFilmRolls {
            Section("Finished film rolls") {
                ForEach(finishedFilmRolls) { filmRoll in
                    NavigationLink(value: Route.filmRoll(filmRoll)) {
                        FilmRollView(filmRoll: filmRoll)
                    }
                }
            }
        }
    }
    
}

#Preview {
    ModelPreview { camera in
        CameraDetailedView(camera: camera)
    }
}
