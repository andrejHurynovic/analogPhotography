//
//  ViewStateToolbar.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 13.06.24.
//

import SwiftUI

struct ViewStateToolbar<Content: View>: ToolbarContent {
    @Binding var viewState: ViewState
    @EnvironmentObject var router: AppRouter
    
    var menuContent: () -> Content
    var createAction: (() -> ())?
    var deleteAction: (() -> ())?
    
    var body: some ToolbarContent {
        switch viewState {
            case .showing: showing
            case .editing: editing
            case .creating: creating
        }
    }
    
    var showing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu("", systemImage: "ellipsis.circle") {
                Button("Edit", systemImage: "pencil") {
                    viewState = .editing
                }
                menuContent()
                if let deleteAction = deleteAction {
                    DeleteButton {
                        deleteAction()
                        router.removeAllWithCurrentModel()
                    }
                }
            }
        }
    }
    
    @ToolbarContentBuilder var creating: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel") {
                router.navigateBack()
            }
        }
        if let saveAction = createAction {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveAction()
                    viewState = .showing
                }
            }
        }
    }
    
    var editing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Done") {
                viewState = .showing
            }
        }
    }
}

fileprivate struct ViewStateToolbarPreview: View {
    @State var viewState: ViewState
    
    var body: some View {
        return NavigationStack {
                EmptyView()
            .toolbar {
                ViewStateToolbar(viewState: $viewState) { EmptyView() } }
        }
    }
    
}

#Preview { return ViewStateToolbarPreview(viewState: .showing) }
#Preview { return ViewStateToolbarPreview(viewState: .creating) }
