//
//  CameraView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.07.24.
//

import SwiftUI

struct CameraView: View {
    @Bindable var camera: Camera
    
    var body: some View {
        VStack(alignment: .leading) {
            name
            note
            filmRoll
        }
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
