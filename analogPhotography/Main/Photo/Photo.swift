//
//  Photo.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
class Photo {
    var film: Film
    
    var date: Date
    var location: Location?
    
    var aperture: String
    var shutterSpeed: String
    
    @Attribute(.externalStorage) var image: Data?
    
    var note: String = ""
    
    init(film: Film, date: Date, location: Location? = nil, aperture: String, shutterSpeed: String, image: Data? = nil, note: String) {
        self.film = film
        self.date = date
        self.location = location
        self.aperture = aperture
        self.shutterSpeed = shutterSpeed
        self.image = image
        self.note = note
    }
}
