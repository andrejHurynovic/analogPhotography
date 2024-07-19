//
//  CreateableModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 19.07.24.
//

import SwiftData

protocol CreateableModel: PersistentModel {
    static func creatingRoute() -> Route
}
