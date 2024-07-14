//
//  CameraView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.07.24.
//

import SwiftUI

struct CameraView: View {
    @StateObject var viewModel: CameraViewModel
    
    init(camera: Camera) {
        self._viewModel = StateObject(wrappedValue: CameraViewModel(camera: camera))
    }
    
    var body: some View {        
        NavigationLink(value: viewModel.camera) {
            VStack(alignment: .leading) {
                name
                note
                currentFilmRoll
            }
        }
        .navigationDestination(for: Camera.self, destination: { CameraDetailedView(camera: $0) })
    }
    
    var name: some View {
        Text(viewModel.camera.name)
            .font(.title2)
            .fontWeight(.bold)
    }
    @ViewBuilder var note: some View {
        if viewModel.camera.note != "" {
            Text(viewModel.camera.note)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
    
    var currentFilmRoll: some View {
            HStack {
                currentFilmRollName
                Spacer()
                filmRoleCapacity
                    .bold()
            }
            .monospaced()
    }
    @ViewBuilder var currentFilmRollName: some View {
        if let currentFilmName = viewModel.filmRollName {
            Text(currentFilmName)
        }
    }
    @ViewBuilder var filmRoleCapacity: some View {
        if let currentFilmRollCapacityDescription = viewModel.currentFilmRollCapacityDescription {
            Text(currentFilmRollCapacityDescription)
        }
    }
}

#Preview {
    ModelPreview { camera in
        NavigationStack {
            List {
                CameraView(camera: camera)
            }
        }
    }
}

