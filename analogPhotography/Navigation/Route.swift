//
//  Route.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.07.24.
//

enum Route: Hashable {
    case camera(Camera)
    case film(Film)
    case filmRoll(FilmRoll)
    case photo(Photo)
    case scanner
    case settings
}
