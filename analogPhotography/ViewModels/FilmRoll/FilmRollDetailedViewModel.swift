//
//  FilmRollDetailedViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 25.07.24.
//

import Foundation

final class FilmRollDetailedViewModel: ModelViewModel<FilmRoll>, ModelViewModelProtocol {
    var name: String { model.name ?? model.film?.name ?? "Roll" }
}
