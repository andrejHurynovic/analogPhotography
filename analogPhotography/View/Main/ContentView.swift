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
            HomeView()
                .routerNavigationDestinations()
        }
        .environmentObject(router)
        
    }
}

#Preview {
    ContentView()
        .dataModelContainer()
}
