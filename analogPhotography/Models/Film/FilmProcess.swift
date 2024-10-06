//
//  FilmProcess.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import Foundation
import SwiftData

@Model
final class FilmProcess {
    @Attribute(.unique) var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static func defaults() -> [FilmProcess] {
        [FilmProcess(name: "C-41"),
         FilmProcess(name: "B&W"),
         FilmProcess(name: "ECN-2"),
         FilmProcess(name: "E-6")]
    }
    
}

extension FilmProcess: Described {
    var uiDescription: String { name }
}
