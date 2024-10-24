//
//  DefaultSortable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 24.10.2024.
//

import Foundation

protocol DefaultSortable {
    static func defaultSortDescriptors() -> [SortDescriptor<Self>]
}
