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
    
    var locationLatitude: Double?
    var locationLongitude: Double?
    
    var aperture: String
    var shutterSpeed: String?
    
    @Attribute(.externalStorage) var image: Data?
    
    var note: String = ""
    
    init(film: Film, date: Date, locationLatitude: Double? = nil, locationLongitude: Double? = nil, aperture: String, shutterSpeed: String? = nil, image: Data? = nil, note: String) {
        self.film = film
        self.date = date
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.aperture = aperture
        self.shutterSpeed = shutterSpeed
        self.image = image
        self.note = note
    }
}
