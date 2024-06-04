//
//  Film.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
class Film {
    @Relationship var camera: Camera?
    @Relationship(inverse: \FilmType.films) var type: FilmType
    
    var name: String = ""
    var note: String = ""
    @Relationship var photos: [Photo]
    
    init(camera: Camera? = nil, type: FilmType, name: String, note: String, photos: [Photo]) {
        self.camera = camera
        self.type = type
        self.name = name
        self.note = note
        self.photos = photos
    }
}
