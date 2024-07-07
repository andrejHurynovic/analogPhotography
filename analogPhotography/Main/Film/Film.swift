//
//  Film.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
final class Film {
    @Relationship(inverse: \Camera.films) var camera: Camera?
    @Relationship(inverse: \FilmType.films) var type: FilmType?
    
    var name: String?
    var note: String = ""
    var finished: Bool = false
    
    @Relationship(inverse: \Photo.film) var photos: [Photo]
    
    init(camera: Camera? = nil, type: FilmType? = nil, name: String? = nil, note: String, finished: Bool, photos: [Photo]) {
        self.camera = camera
        self.type = type
        self.name = name
        self.note = note
        self.finished = finished
        self.photos = photos
    }
}
