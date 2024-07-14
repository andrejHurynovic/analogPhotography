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
    var order: Int
    var date: Date? = Date.now
    var location: Location?
    
    var aperture: String = ""
    var shutterSpeed: String = ""
    
    var ruined: Bool = false
    var note: String = ""
    
    @Attribute(.externalStorage) var image: Data?
    
    @Relationship var filmRoll: FilmRoll?
    
    init(date: Date? = .now,
         location: Location? = nil,
         aperture: String = "",
         shutterSpeed: String = "",
         ruined: Bool = false, 
         note: String = "",
         image: Data? = nil,
         filmRoll: FilmRoll?) {
        self.order = filmRoll!.photos.count
        self.date = date
        self.location = location
        self.aperture = aperture
        self.shutterSpeed = shutterSpeed
        self.ruined = ruined
        self.note = note
        self.image = image
        self.filmRoll = filmRoll
    }
}
