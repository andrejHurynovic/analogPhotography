//
//  CameraViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 14.07.24.
//

import SwiftUI

class CameraViewModel: ObservableObject {
    @Published var camera: Camera
    
    init(camera: Camera) {
        self.camera = camera
    }
    
    var filmRollName: String? {
        guard let filmRoll = camera.currentFilmRoll else  { return nil }
        return filmRoll.name ?? filmRoll.film?.name
    }
    var currentFilmRollCapacityDescription: String? {
        guard let filmRoll = camera.currentFilmRoll else  { return nil }
        var description: String = String(filmRoll.photos.count)
        if let film = filmRoll.film,
           let capacity = film.capacity {
            description += "/\(capacity)"
        }
        return description
    }
}
