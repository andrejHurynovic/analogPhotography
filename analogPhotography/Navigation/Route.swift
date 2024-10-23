//
//  Route.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.07.24.
//

import SwiftUICore

enum Route: Hashable {
    case camera(Camera, Binding<Camera?>? = nil)
    case cameras
    case film(Film, Binding<Film?>? = nil)
    case films
    case filmRoll(FilmRoll, Binding<FilmRoll?>? = nil)
    case filmRolls
    case photo(Photo, Binding<Photo?>? = nil)
    case photos
    case scannerFilmPickerView(Binding<Film?>? = nil)
    case settings
}
