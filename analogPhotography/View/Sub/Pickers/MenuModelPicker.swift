//
//  MenuModelPicker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.07.24.
//

import SwiftUI
import SwiftData

struct MenuModelPicker<Content: View, Model: PersistentModel>: View {
    @Query var models: [Model]
    @Binding var selectedValue: Model?
    private let title: String
    @ViewBuilder var content: ([Model]) -> Content
    
    init(sort: [SortDescriptor<Model>] = [],
         selectedValue: Binding<Model?>,
         title: String,
         @ViewBuilder content: @escaping ([Model]) -> Content) {
        self._models = Query(sort: sort)
        self._selectedValue = selectedValue
        self.title = title
        self.content = content
    }
    
    var body: some View {
        Picker(title, selection: $selectedValue) {
            Text("-")
                .tag(nil as Model?)
            content(models)
        }
    }
}
