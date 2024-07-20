//
//  ViewStateToolbar.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 13.06.24.
//

import SwiftUI
import SwiftData

struct ViewStateToolbar<Content: View, Model: PersistentModel>: ToolbarContent {
    @ObservedObject var viewModel: ModelViewModel<Model>
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: AppRouter
    
    var menuContent: () -> Content
    
    var body: some ToolbarContent {
        switch viewModel.viewState {
            case .showing: showing
            case .editing: editing
            case .creating: creating
        }
    }
    
    var showing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu("", systemImage: "ellipsis.circle") {
                Button("Edit", systemImage: "pencil") {
                    viewModel.viewState = .editing
                }
                menuContent()
                deleteButton
            }
        }
    }
    
    var editing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Done") {
                viewModel.viewState = .showing
            }
        }
    }
    @ToolbarContentBuilder var creating: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel") {
                router.removeAllWithCurrentModel()
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Save") {
                viewModel.insert(in: modelContext)
                viewModel.viewState = .showing
            }
        }
    }
    var deleteButton: some View {
        DeleteButton {
            viewModel.delete(in: modelContext)
            router.removeAllWithCurrentModel()
        }
    }
}
