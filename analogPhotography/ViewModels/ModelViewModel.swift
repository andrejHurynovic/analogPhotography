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
    
    required init(model: Model) {
        self.model = model
        self.viewState = model.modelContext != nil ? .showing : .creating
    }
    
    func delete(in modelContext: ModelContext) {
        modelContext.delete(model)
    }
    func insert(in modelContext: ModelContext) {
        modelContext.insert(model)
        viewState = .showing
    }
}
