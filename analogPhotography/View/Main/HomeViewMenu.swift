//
//  HomeViewMenu.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 7.10.24.
//

import SwiftUI

struct HomeViewMenu: View {
    var body: some View {
        Menu {
            NavigationLink(value: Route.camera(Camera())) {
                Label("Add camera", systemImage: "camera")
            }
            NavigationLink(value: Route.film(Film())) {
                Label("Add film", systemImage: "film.stack")
            }
            NavigationLink(value: Route.scanner) {
                Label("Add film from barcode or DXCode", systemImage: "scanner")
            }
            NavigationLink(value: Route.filmRoll(FilmRoll())) {
                Label("Add film roll", systemImage: "film")
            }
            NavigationLink("cameras", value: Route.cameras)
            NavigationLink("films", value: Route.films)
            NavigationLink("filmRolls", value: Route.filmRolls)
            NavigationLink("photos", value: Route.photos)
        } label: {
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(1.0, contentMode: .fill)
                .frame(width: 16, height: 16)
                .padding()
                .background(.thinMaterial, in: Circle())
            
        }
        NavigationLink(value: Route.settings) {
            Image(systemName: "gear")
                .resizable()
                .aspectRatio(1.0, contentMode: .fill)
                .frame(width: 16, height: 16)
                .padding()
                .background(.thinMaterial, in: Circle())
        }
    }
}

#Preview {
    RoutedNavigationStack {
        ZStack {
            Color(uiColor: UIColor.systemGroupedBackground)
            HStack {
                HomeViewMenu()
            }
        }
    }
}
