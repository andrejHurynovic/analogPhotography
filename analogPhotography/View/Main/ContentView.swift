//
//  ContentView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            let _ = print(router.path)
            TabView {
                CamerasView()
                    .tabItem {
                        Label("Cameras", systemImage: "camera")
                    }
                FilmRollsView()
                    .tabItem {
                        Label("Film rolls", systemImage: "contact.sensor")
                    }
                ScannerView()
                    .tabItem {
                        Label("Scanner", systemImage: "scanner")
                    }
            }
            .routerNavigationDestinations()
        }
        .environmentObject(router)
    }
    
}

#Preview {
    ContentView()
        .modelContainer(DataContainer().getContainer())
}
