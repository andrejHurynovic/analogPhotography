//
//  Route.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.07.24.
//

enum Route: Hashable {
    case camera(Camera)
    case cameras
    case film(Film)
    case films
    case filmRoll(FilmRoll)
    case filmRolls
    case photo(Photo)
    case photos
    case scanner
    case settings
}
