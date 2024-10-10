//
//  Film+CreateableModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

extension Film: CreateableModel {
    static func creatingRoute() -> Route { .film(Film()) }
}
