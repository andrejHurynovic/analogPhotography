//
//  CameraRowView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.07.24.
//

import SwiftUI

struct CameraRowView: View {
    @StateObject var viewModel: CameraRowViewModel
    
    init(camera: Camera) {
        self._viewModel = StateObject(wrappedValue: CameraRowViewModel(camera: camera))
    }
    
    var body: some View {
        NavigationLink(value: Route.camera(viewModel.camera)) {
            VStack(alignment: .leading) {
                name
                note
                currentFilmRoll
            }
        }
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
                rollName
                Spacer()
                filmRollCapacity
                    .bold()
            }
            .monospaced()
    }
    @ViewBuilder var rollName: some View {
        if let rollName = viewModel.filmRollName {
            Text(rollName)
        }
    }
    @ViewBuilder var filmRollCapacity: some View {
        if let rollCapacityDescription = viewModel.currentFilmRollCapacityDescription {
            Text(rollCapacityDescription)
        }
    }
}

#Preview {
    ModelPreview { camera in
        List {
            CameraRowView(camera: camera)
        }
    }
}

