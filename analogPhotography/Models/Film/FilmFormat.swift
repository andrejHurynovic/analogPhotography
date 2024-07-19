//
//  FilmFormat.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
final class FilmFormat {
    @Attribute(.unique) var name: String
    var length: Int?
    var outdated: Bool?

    init(name: String, length: Int? = nil, outdated: Bool? = nil) {
        self.name = name
        self.length = length
        self.outdated = outdated
    }
    
    static func defaults() -> [FilmFormat] {
        [   // Currently used
            FilmFormat(name: "110", length: 16, outdated: false),
            FilmFormat(name: "120", length: 60, outdated: false),
            FilmFormat(name: "127", length: 40, outdated: false),
            FilmFormat(name: "135", length: 35, outdated: false),
            
            // Outdated
            FilmFormat(name: "116", length: 70, outdated: true),
            FilmFormat(name: "220", length: 60, outdated: true),
            FilmFormat(name: "620", length: 60, outdated: true),
            FilmFormat(name: "127", length: 40, outdated: true),
            FilmFormat(name: "828", length: 35, outdated: true),
            FilmFormat(name: "APS", length: 24, outdated: true)]
    }
    
}
