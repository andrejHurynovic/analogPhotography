//
//  FilmRollsGenericView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmRollsGenericView<Content: View>: View {
    @State var searchText: String = ""
    @ViewBuilder var content: ([FilmRoll]) -> Content
    
    var body: some View {
        ModelsView(filter: #Predicate {
            searchText.isEmpty ||
            $0.name?.localizedStandardContains(searchText) ?? false
        },
                   sort: [SortDescriptor(\FilmRoll.name)],
                   navigationTitle: "Films") { filmRolls in
            content(filmRolls)
                .searchable(text: $searchText, placement: .automatic, prompt: "Search")
        }
    }
}

#Preview {
    NavigationStackPreview {
        FilmRollsView()
    }
}
