//
//  Camera+DefaultSortable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 24.10.2024.
//

import Foundation

extension Camera: DefaultSortable {
    static func defaultSortDescriptors() -> [SortDescriptor<Camera>] { [SortDescriptor(\.name)] }
}
