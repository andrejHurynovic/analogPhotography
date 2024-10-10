//
//  ModelsView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 19.07.24.
//

import SwiftUI
import SwiftData

struct ModelsView<Content: View, Model: CreateableModel>: View {
    @Query var models: [Model]
    
    let navigationTitle: String
    @ViewBuilder var content: ([Model]) -> Content
    
    init(filter: Predicate<Model>? = nil,
         sort: [SortDescriptor<Model>] = [],
         navigationTitle: String,
         content: @escaping ([Model]) -> Content) {
        self._models = Query(filter: filter, sort: sort)
        self.navigationTitle = navigationTitle
        self.content = content
    }
    
    var body: some View {
        content(models)
            .toolbar(content: {
                NavigationLink("Add", value: Model.creatingRoute())
            })
            .navigationTitle(navigationTitle)
            .overlay { contentUnavailable }
    }
    
    @ViewBuilder var contentUnavailable: some View {
        if models.isEmpty == true {
            ContentUnavailableView(label: {
                Label("No \(navigationTitle)", systemImage: "xmark.bin")
            }, description: {
                Text("You're \(navigationTitle) will appear here.")
            }, actions: {
                NavigationLink("Create new", value: Model.creatingRoute())
            })
        }
    }
}
