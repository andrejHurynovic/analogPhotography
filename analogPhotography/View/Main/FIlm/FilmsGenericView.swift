//
//  FilmsGenericView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmsGenericView<FilmType: FilmProtocol, Content: View>: View {
    @State var searchText: String = ""
    var selectedFilm: Binding<FilmType?>?
    @ViewBuilder var content: ([FilmType]) -> Content
    
    var body: some View {
        ModelsView(filter: nil,
                   navigationTitle: "Films") { films in
            content(films)
                .searchable(text: $searchText, placement: .automatic, prompt: "Search")
        } toolbarContent: {
            ToolbarItem {
                Menu("Add") {
                    NavigationLink("Add film", value: Route.film(Film(), selectedFilm as! Binding<Film?>?))
                    NavigationLink("Scan barcode or DXCode", value: Route.scannerFilmPickerView(selectedFilm as! Binding<Film?>?))
                }
            }
        }
    }
}

#Preview {
    RoutedNavigationStack {
        FilmsView<Film>()
    }
}
