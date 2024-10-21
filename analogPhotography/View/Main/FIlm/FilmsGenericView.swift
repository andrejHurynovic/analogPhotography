//
//  FilmsGenericView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmsGenericView<Content: View>: View {
    @State var searchText: String = ""
    @ViewBuilder var content: ([Film]) -> Content
    
    var body: some View {
        ModelsView(filter: #Predicate {
            searchText.isEmpty ||
            $0.name?.localizedStandardContains(searchText) ?? false
        },
                   sort: [SortDescriptor(\Film.name)],
                   navigationTitle: "Films") { films in
            content(films)
//                .searchable(text: $searchText, placement: .automatic, prompt: "Search")
        }
    }
}

#Preview {
    RoutedNavigationStack {
        FilmsView()
    }
}
