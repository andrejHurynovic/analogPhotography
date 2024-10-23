//
//  CamerasGenericView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.07.24.
//

import SwiftUI

struct CamerasGenericView<Content: View>: View {
    @State var searchText: String = ""
    @ViewBuilder var content: ([Camera]) -> Content
    
    var body: some View {
        ModelsView(filter: #Predicate { searchText.isEmpty || $0.name.localizedStandardContains(searchText) },
                   sort: [SortDescriptor(\Camera.name)],
                   navigationTitle: "Cameras") { cameras in
            content(cameras)
                .searchable(text: $searchText, placement: .automatic, prompt: "Search")
        } toolbarContent: {
            ToolbarItem {
                NavigationLink("Add", value: Camera.creatingRoute())
            }
        }
    }
}

#Preview {
    RoutedNavigationStack {
        CamerasView()
    }
}
