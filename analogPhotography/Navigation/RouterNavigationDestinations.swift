//
//  RouterNavigationDestinations.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 18.07.24.
//

import SwiftUI

private struct RouterNavigationDestinations: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .camera(let camera, let selectedCamera):
                    CameraDetailedView(camera: camera, selectedCamera: selectedCamera)
                case .cameras:
                    CamerasView()
                case .film(let film, let selectedFilm):
                    FilmDetailedView(film: film, selectedFilm: selectedFilm)
                case .films:
                    FilmsView()
                case .filmRoll(let filmRoll, let selectedFilmRoll):
                    FilmRollDetailedView(filmRoll: filmRoll, selectedFilmRoll: selectedFilmRoll)
                case .filmRolls:
                    FilmRollsView()
                case .photo(let photo, let selectedPhoto):
                    PhotoDetailedView(photo: photo, selectedPhoto: selectedPhoto)
                case .photos:
                    PhotosView()
                case .scannerFilmPickerView(let selectedFilm):
                    ScannerFilmPickerView(selectedFilm: selectedFilm)
                case .settings:
                    EmptyView()
                }
            }
    }
}

extension View {
    func routerNavigationDestinations() -> some View {
        self.modifier(RouterNavigationDestinations())
    }
}
