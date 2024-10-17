//
//  FilmRoll+Described.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 18.10.2024.
//


extension FilmRoll: Described {
    var uiDescription: String { name ?? film?.name ?? "Film roll" }
    
    var capacityDescription: String {
        var description = self.photos.count.formatted()
        if let film = self.film,
           let capacity = film.capacity {
            description += "/\(capacity)"
        }
        return description
    }
}
