//
//  FilmsView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmsView<FilmType: FilmProtocol>: View {
    var body: some View {
        FilmsGenericView { films in
            List(films) { film in
                NavigationLink(value: Route.film(film as! Film)) {
                    FilmView<FilmType>(film: film)
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
