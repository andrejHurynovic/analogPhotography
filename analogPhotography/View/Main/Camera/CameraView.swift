//
//  CameraView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.07.24.
//

import SwiftUI

struct CameraView: View {
    @Bindable var camera: Camera
    @State var pickedFilm: Film?
    @State var showFilmPicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            name
            note
            filmRoll
        }
        .sheet(isPresented: $showFilmPicker) {
            if let film = pickedFilm {
                camera.addFilmRoll(film: film)
            }
        } content: {
            FilmPickerSheet(isPresented: $showFilmPicker, picked: $pickedFilm)
        }
        .animation(.default, value: camera.currentFilmRoll)
    }
    
    var name: some View {
        Text(camera.name)
            .font(.title2)
            .fontWeight(.bold)
    }
    @ViewBuilder var note: some View {
        if camera.note != "" {
            Text(camera.note)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
    
    //MARK: FilmRoll
    @ViewBuilder var filmRoll: some View {
        if let currentFilmRoll = camera.currentFilmRoll {
            FilmRollMinimizedView(filmRoll: currentFilmRoll)
        } else {
            Button("Select new film") {
                showFilmPicker = true
            }
            .buttonStyle(CellButtonStyle())
        }
    }
    
    //MARK: FilmPicker
    
    
}

#Preview {
    ModelPreview { camera in
        Form {
            CameraView(camera: camera)
        }
    }
}
