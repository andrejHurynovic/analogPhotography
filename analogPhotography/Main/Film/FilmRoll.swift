//
//  FilmRoll.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
final class FilmRoll {
    var name: String = ""
    var note: String = ""
    
    var creationDate: Date = Date()
    var finished: Bool = false
    
    @Relationship(inverse: \Film.rolls) var type: Film?
    @Relationship(inverse: \Photo.filmRoll) var photos: [Photo]
    
    @Relationship(inverse: \Camera.filmRolls) var camera: Camera?
    
    init(name: String = "", note: String = "", creationDate: Date = .now, finished: Bool = false, type: Film? = nil, photos: [Photo] = [], camera: Camera? = nil) {
        self.name = name
        self.note = note
        self.creationDate = creationDate
        self.finished = finished
        self.type = type
        self.photos = photos
        self.camera = camera
    }
}
