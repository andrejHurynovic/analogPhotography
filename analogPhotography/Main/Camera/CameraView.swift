//
//  CameraView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.07.24.
//

import SwiftUI
import SwiftData

struct CameraView: View {
    @Bindable var camera: Camera
    
    var body: some View {
        NavigationLink(value: camera) {
            HStack {
                VStack(alignment: .leading) {
                    name
                    note
                }
//                currentFilm
            }
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
//    @ViewBuilder var currentFilm: some View {
//        if let currentFilm = camera.getCurrentFilm() {
//            if let filmType = currentFilm.type,
//               let capacity = filmType.capacity {
//                Text("\(currentFilm.photos.count)/\(capacity)")
//            }
//        }
//    }
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

