//
//  PhotosGenericView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct PhotosGenericView<Content: View>: View {
    @State var searchText: String = ""
    @ViewBuilder var content: ([Photo]) -> Content
    
    var body: some View {
        ModelsView(filter: #Predicate {
            searchText.isEmpty ||
            $0.locationDescription?.localizedStandardContains(searchText) ?? false
        },
                   sort: [SortDescriptor(\Photo.order)],
                   navigationTitle: "Films") { photos in
            content(photos)
                .searchable(text: $searchText, placement: .automatic, prompt: "Search")
        }
    }
}

#Preview {
    NavigationStackPreview {
        PhotosView()
    }
}
