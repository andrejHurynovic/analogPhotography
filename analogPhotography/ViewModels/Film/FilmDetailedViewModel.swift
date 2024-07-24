//
//  FilmDetailedViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.07.24.
//

import Foundation

final class FilmDetailedViewModel: ModelViewModel<Film>, ModelViewModelProtocol {
    var name: String { model.name ?? "Film"}
}

