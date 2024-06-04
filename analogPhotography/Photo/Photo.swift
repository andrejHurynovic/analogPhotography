//
//  Photo.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Photo {
    var film: Film
    
    var date: Date
    
    var locationLatitude: Double?
    var locationLongitude: Double?
    
    var aperture: Float?
    var shutterSpeed: Float?
    
    @Attribute(.externalStorage) var image: Data?
    
    var note: String = ""
    
    init(film: Film, date: Date, locationLatitude: Double? = nil, locationLongitude: Double? = nil, aperture: Float? = nil, shutterSpeed: Float? = nil, image: Data? = nil, note: String) {
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
