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
                case .camera(let camera):
                    CameraDetailedView(camera: camera)
                case .film(let film):
                    FilmDetailedView(film: film)
                case .filmRoll(let filmRoll):
                    FilmRollDetailedView(filmRoll: filmRoll)
                case .photo(let photo):
                    PhotoDetailedView(photo: photo)
                case .scanner:
                    ScannerView()
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
