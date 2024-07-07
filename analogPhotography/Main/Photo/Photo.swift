//
//  Photo.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
final class Photo {
    @Relationship var film: Film
    
    var order: Int
    var date: Date?
    var location: Location?
    
    var aperture: String = ""
    var shutterSpeed: String = ""
    
    var ruined: Bool = false
    
    @Attribute(.externalStorage) var image: Data?
    
    var note: String = ""
    
    init(film: Film, order: Int, date: Date? = nil, location: Location? = nil, aperture: String, shutterSpeed: String, ruined: Bool, image: Data? = nil, note: String) {
        self.film = film
        self.order = order
        self.date = date
        self.location = location
        self.aperture = aperture
        self.shutterSpeed = shutterSpeed
        self.ruined = ruined
        self.image = image
        self.note = note
    }
}
