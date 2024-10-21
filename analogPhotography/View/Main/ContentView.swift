//
//  ContentView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        RoutedNavigationStack {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
        .dataModelContainer()
}
