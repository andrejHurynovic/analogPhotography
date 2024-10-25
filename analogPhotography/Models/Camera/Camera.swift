//
//  Camera.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftData

@Model
final class Camera: CameraProtocol {
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
    func changeCurrentFilmRoll(film: Film, in modelContext: ModelContext) {
        guard let oldFilmRoll = currentFilmRoll else { return }
        
        try? modelContext.transaction {
            let newFilmRoll = FilmRoll(film: film)
            
            for photo in oldFilmRoll.photos {
                photo.filmRoll = newFilmRoll
            }
            
            modelContext.insert(newFilmRoll)
            modelContext.delete(oldFilmRoll)
            
            self.filmRolls.append(newFilmRoll)
        }
    }
    func deleteCurrentFilmRoll(in modelContext: ModelContext) {
        guard let currentFilmRoll = currentFilmRoll,
              let currentFilmRollIndex = self.filmRolls.firstIndex(of: currentFilmRoll) else { return }
        self.filmRolls.remove(at: currentFilmRollIndex)
        modelContext.delete(currentFilmRoll)
    }
    
    var currentFilmRoll: FilmRoll? { filmRolls.first { !$0.finished } }
    var finishedFilmRolls: [FilmRoll]? {
        let filmRolls = self.filmRolls.filter { $0.finished == true }
        guard !filmRolls.isEmpty else { return nil }
        return filmRolls
    }
}
