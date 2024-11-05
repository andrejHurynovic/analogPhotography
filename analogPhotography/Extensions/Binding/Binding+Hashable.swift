//
//  Binding+Hashable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 23.10.2024.
//

import SwiftUICore

extension Binding: @retroactive Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.wrappedValue)
    }
}
