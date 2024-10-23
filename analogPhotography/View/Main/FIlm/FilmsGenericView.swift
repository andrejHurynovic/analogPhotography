//
//  FilmsGenericView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmsGenericView<Content: View>: View {
    @State var searchText: String = ""
    var selectedFilm: Binding<Film?>?
    @ViewBuilder var content: ([Film]) -> Content
    
    var body: some View {
        ModelsView(filter: #Predicate {
            searchText.isEmpty ||
            $0.name?.localizedStandardContains(searchText) ?? false
        },
                   sort: [SortDescriptor(\Film.name)],
                   navigationTitle: "Films") { films in
            content(films)
                .searchable(text: $searchText, placement: .automatic, prompt: "Search")
        } toolbarContent: {
            ToolbarItem {
                Menu("Add") {
                    NavigationLink("Add film", value: Route.film(Film(), selectedFilm))
                    NavigationLink("Add film with barcode or DXCode", value: Route.scanner)
                }
            }
        }
    }
}

#Preview {
    RoutedNavigationStack {
        FilmsView()
    }
}
