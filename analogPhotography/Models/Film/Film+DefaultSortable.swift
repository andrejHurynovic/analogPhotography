//
//  Film+DefaultSortable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 24.10.2024.
//

import Foundation

extension Film: DefaultSortable {
    static func defaultSortDescriptors() -> [SortDescriptor<Film>] { [SortDescriptor(\.name)] }
}
