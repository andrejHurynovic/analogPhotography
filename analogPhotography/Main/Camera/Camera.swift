//
//  Camera.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
class Camera {
    var name: String
    var note: String = ""
    
    @Relationship(inverse: \Film.camera) var films: [Film]
    
    init(name: String, note: String, Films: [Film]) {
        self.name = name
        self.note = note
        self.films = Films
    }
}
