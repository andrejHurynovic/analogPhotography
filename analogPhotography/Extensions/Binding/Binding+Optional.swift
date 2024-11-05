//
//  Binding.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 24.07.24.
//

import SwiftUI

extension Binding<String?> {
    func unwrappedOptional() -> Binding<String> {
        return Binding<String>(
            get: {
                return self.wrappedValue ?? ""
            },
            set: {
                self.wrappedValue = $0.isEmpty ? nil : $0
            })
    }
}

extension Binding<Int?> {
    func unwrappedOptional() -> Binding<String> {
        return Binding<String>(
            get: {
                guard let value = self.wrappedValue else { return "" }
                return String(value)
            },
            set: {
                self.wrappedValue = Int($0)
            })
    }
}
