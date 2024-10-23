//
//  FilmRollsView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.07.24.
//

import SwiftUI

struct FilmRollsView: View {
    var body: some View {
        FilmRollsGenericView { filmRolls in
            List(filmRolls) { filmRoll in
                NavigationLink(value: Route.filmRoll(filmRoll)) {
                    FilmRollView(filmRoll: filmRoll)
                }
            }
        }
    }
}

#Preview {
    RoutedNavigationStack {
        FilmRollsView()
    }
}
