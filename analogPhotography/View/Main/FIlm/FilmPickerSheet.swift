//
//  FilmPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmPickerSheet: View {
    @EnvironmentObject var manager: ModelPickerSheetManager
    @Binding var picked: Film?
    @StateObject var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            FilmsGenericView(selectedFilm: $picked) { films in
                ModelPickerSheet(isPresented: $manager.isPresented,
                                 selectedElement: $picked,
                                 elements: films) { film in
                    FilmView(film: film)
                }
            }
            .routerNavigationDestinations()
        }
        .environmentObject(router)
    }
}

#Preview {
    @Previewable @State var manager = ModelPickerSheetManager()
    @Previewable @State var picked: Film?
    
    RoutedNavigationStack {
        Form {
            Button("Select film") {
                manager.isPresented = true
            }
            if let picked = picked {
                FilmView(film: picked)
            } else {
                Text("No selected film")
            }
        }
        .sheet(isPresented: $manager.isPresented) {
            FilmPickerSheet(picked: $picked)
                .environmentObject(manager)
        }
    }
    
}
