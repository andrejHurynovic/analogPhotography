//
//  DetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.07.24.
//

import SwiftUI
import SwiftData

struct DetailedView<Content: View, Model: PersistentModel, ViewModel: ModelViewModel<Model> & ModelViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    var content: (ViewModel, ObservedObject<ViewModel>.Wrapper) -> Content
    
    init(model: Model, viewModelType: (ViewModel.Type), content: @escaping (ViewModel, ObservedObject<ViewModel>.Wrapper) -> Content) {
        self._viewModel = StateObject(wrappedValue: ViewModel(model: model))
        self.content = content
    }
    
    var body: some View {
        content(viewModel, $viewModel)
            .navigationTitle(viewModel.name)
            .navigationBarBackButtonHidden(viewModel.viewState == .creating)
            .toolbar { toolbarContent }
    }
    
    private var toolbarContent: some ToolbarContent {
        ViewStateToolbar(viewModel: viewModel) { EmptyView() }
    }
}
