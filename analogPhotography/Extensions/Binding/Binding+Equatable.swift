//
//  Binding+Equatable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 23.10.2024.
//

import SwiftUICore

extension Binding: @retroactive Equatable where Value: Equatable {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}
