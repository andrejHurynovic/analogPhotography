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
    var selectedModel: Binding<Model?>?
    @Published var viewState: ViewState
    
    required init(model: Model, selectedModel: Binding<Model?>? = nil) {
        self.model = model
        self.selectedModel = selectedModel
        if model.modelContext == nil {
            self.viewState = .showing
        } else {}
        self.viewState = selectedModel == nil ? .creating : .creatingAndSelecting
        
    }
    
    func delete(in modelContext: ModelContext) {
        modelContext.delete(model)
    }
    func insert(in modelContext: ModelContext) {
        modelContext.insert(model)
        viewState = .showing
    }
}
