//
//  Camera.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftData

@Model
final class Camera {
    var name: String = ""
    var note: String = ""
    
    @Relationship var filmRolls: [FilmRoll] = []
    
    init(name: String = "", note: String = "", filmRolls: [FilmRoll] = []) {
        self.name = name
        self.note = note
        self.filmRolls = filmRolls
    }
}

extension Camera {
    func addFilmRoll(film: Film) {
        self.filmRolls.append(FilmRoll(film: film, camera: self))
    }
    
    var currentFilmRoll: FilmRoll? { filmRolls.first { !$0.finished } }
}
