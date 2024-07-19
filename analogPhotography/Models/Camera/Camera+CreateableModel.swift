//
//  Camera+CreateableModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 19.07.24.
//

extension Camera: CreateableModel {
    static func creatingRoute() -> Route { .camera(Camera()) }
}
