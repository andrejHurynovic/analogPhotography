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
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var modelPickerSheetManager: ModelPickerSheetManager
    
    var menuContent: () -> Content
    
    var body: some ToolbarContent {
        switch viewModel.viewState {
        case .showing: showing
        case .editing: editing
        case .creating, .creatingAndSelecting: creatingAndSelecting
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
    
    @ToolbarContentBuilder var creatingAndSelecting: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
                router.removeAllWithCurrentModel()
            }
            .navigationBarBackButtonHidden(true)
        }
        ToolbarItem(placement: .confirmationAction) {
            switch viewModel.viewState {
            case .creating:
                Button("Save") {
                    viewModel.insert(in: modelContext)
                    viewModel.viewState = .showing
                }
            case .creatingAndSelecting:
                Button("Select") {
                    viewModel.insert(in: modelContext)
                    viewModel.selectedModel?.wrappedValue = viewModel.model
                    modelPickerSheetManager.isPresented = false
                }
            default: EmptyView()
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
