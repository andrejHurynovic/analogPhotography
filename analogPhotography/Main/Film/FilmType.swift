//
//  FilmType.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftData

@Model
final class FilmType {
    var name: String
    
    var capacity: Int?
    var iso: Int?
    var expired: Bool?
    
    @Relationship var format: FilmFormat?
    @Relationship var process: FilmProcess?
    @Relationship var films: [Film]
    
    init(name: String, capacity: Int? = nil, iso: Int? = nil, expired: Bool? = nil, format: FilmFormat? = nil, process: FilmProcess? = nil, films: [Film]) {
        self.name = name
        self.capacity = capacity
        self.iso = iso
        self.expired = expired
        self.format = format
        self.process = process
        self.films = films
    }
    
}
