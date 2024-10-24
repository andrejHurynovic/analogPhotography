//
//  FilmRoll+DefaultSortable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 24.10.2024.
//

import Foundation

extension FilmRoll: DefaultSortable {
    static func defaultSortDescriptors() -> [SortDescriptor<FilmRoll>] { [SortDescriptor(\.name)] }
}
