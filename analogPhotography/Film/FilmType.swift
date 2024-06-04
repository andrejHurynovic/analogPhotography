//
//  FilmType.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
class FilmType {
    var name: String
    
    var capacity: Int?
    var iso: Int?
    var expired: Bool
    
    @Relationship var films: [Film]
    @Relationship var format: FilmFormat?
    @Relationship var process: FilmProcess?
    
    init(name: String, capacity: Int? = nil, iso: Int? = nil, expired: Bool, films: [Film], format: FilmFormat? = nil, process: FilmProcess? = nil) {
        self.name = name
        self.capacity = capacity
        self.iso = iso
        self.expired = expired
        self.films = films
        self.format = format
        self.process = process
    }
    
}
