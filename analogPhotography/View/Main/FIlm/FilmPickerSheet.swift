//
//  FilmPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmPickerSheet: View {
    @Binding var isPresented: Bool
    @Binding var picked: Film?
    @StateObject var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            FilmsGenericView { films in
                ModelPickerSheet(isPresented: $isPresented,
                                 selectedElement: $picked,
                                 elements: films) { film in
                    FilmView(film: film)
                }
            }
            .routerNavigationDestinations()
        }
        
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    @Previewable @State var picked: Film?
    
    RoutedNavigationStack {
        Form {
            Button("Select film") {
                isPresented = true
            }
            if let picked = picked {
                FilmView(film: picked)
            } else {
                Text("No selected film")
            }
        }
        .sheet(isPresented: $isPresented) {
            FilmPickerSheet(isPresented: $isPresented, picked: $picked)
        }
    }
    
}
