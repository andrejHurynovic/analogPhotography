//
//  Photo+DefaultSortable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 24.10.2024.
//

import Foundation

extension Photo: DefaultSortable {
    static func defaultSortDescriptors() -> [SortDescriptor<Photo>] { [SortDescriptor(\.order)] }
}
