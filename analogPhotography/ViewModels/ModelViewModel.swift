//
//  ModelViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 19.07.24.
//

import SwiftUI
import SwiftData

class ModelViewModel<Model: PersistentModel>: ObservableObject {
    @Published var model: Model
    @Published var viewState: ViewState
    
    init(model: Model, viewState: ViewState = .showing) {
        self.model = model
        self.viewState = viewState
    }
    
    func delete(in modelContext: ModelContext) {
        modelContext.delete(model)
    }
    func insert(in modelContext: ModelContext) {
        modelContext.insert(model)
    }
}
