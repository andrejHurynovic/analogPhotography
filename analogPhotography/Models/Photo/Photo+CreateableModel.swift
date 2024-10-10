//
//  Photo+CreateableModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

extension Photo: CreateableModel {
    static func creatingRoute() -> Route { .photo(Photo()) }
}

