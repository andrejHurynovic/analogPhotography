//
//  Binding<String?>+Prefixed.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 05.11.2024.
//

import SwiftUICore

extension Binding<String?> {
    func prefixed(with prefix: String) -> Binding<String> {
        return Binding<String>(
            get: {
                guard let value = self.wrappedValue else { return "" }
                return prefix+String(value)
            },
            set: {
                guard $0.hasPrefix(prefix) else {
                    self.wrappedValue = nil
                    return
                }
                self.wrappedValue = $0.removingFirst(prefix.count)
            })
    }
}
