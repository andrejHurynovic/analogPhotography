//
//  FilmDetailedViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.07.24.
//

import Foundation

final class FilmDetailedViewModel<FilmType: FilmProtocol>: ModelViewModel<FilmType>, ModelViewModelProtocol {
    var name: String { model.name ?? "Film"}
}

