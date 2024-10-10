//
//  FilmRoll+CreateableModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

extension FilmRoll: CreateableModel {
    static func creatingRoute() -> Route { .filmRoll(FilmRoll()) }
}
