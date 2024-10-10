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
        VStack(alignment: .leading) {
            name
            note
            currentFilmRoll
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
    
    //MARK: FilmRoll
    @ViewBuilder var currentFilmRoll: some View {
        if viewModel.isFilmRollVisiable {
            HStack {
                rollName
                Spacer()
                rollCapacity
                    .bold()
            }
            .monospaced()
        }
    }
    @ViewBuilder var rollName: some View {
        if let rollName = viewModel.filmRollName {
            Text(rollName)
        }
    }
    @ViewBuilder var rollCapacity: some View {
        if let rollCapacityDescription = viewModel.currentFilmRollCapacityDescription {
            Text(rollCapacityDescription)
        }
    }
}

#Preview {
    ModelPreview { camera in
        Form {
            CameraView(camera: camera)
        }
    }
}

