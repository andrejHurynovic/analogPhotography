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
    var name: String?
    var note: String = ""
    
    var expired: Bool
    var creationDate: Date
    var finished: Bool = false
    
    @Relationship(inverse: \Film.rolls) var film: Film?
    @Relationship(deleteRule: .cascade, inverse: \Photo.filmRoll) var photos: [Photo]
    
    @Relationship(inverse: \Camera.filmRolls) var camera: Camera?
    
    init(name: String? = nil , note: String = "", expired: Bool = false, creationDate: Date = .now, finished: Bool = false, film: Film? = nil, photos: [Photo] = [], camera: Camera? = nil) {
        self.name = name
        self.note = note
        self.expired = expired
        self.creationDate = creationDate
        self.finished = finished
        self.film = film
        self.photos = photos
        self.camera = camera
    }
}

extension FilmRoll {
    var isOfferToFinish: Bool? {
        guard let capacity = self.film?.capacity else { return nil }
        return capacity - photos.count < Constants.FilmRoll.numberOfPhotosLeftToShowFinishButton
    }
}
