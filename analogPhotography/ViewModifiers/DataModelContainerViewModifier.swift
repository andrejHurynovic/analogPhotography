//
//  DataModelContainerViewModifier.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 7.10.24.
//

import SwiftUI
import SwiftData

fileprivate struct DataModelContainerViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modelContainer(DataContainer().getContainer())
    }
}

extension View {
    func dataModelContainer() -> some View {
        modifier(DataModelContainerViewModifier())
    }
}
