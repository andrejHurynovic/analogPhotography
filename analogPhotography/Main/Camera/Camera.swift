//
//  Camera.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
final class Camera {
    var name: String
    var note: String = ""
    
    @Relationship var films: [Film] = []
    
    init(name: String, note: String, films: [Film]) {
        self.name = name
        self.note = note
        self.films = films
    }
}
