//
//  RoutedNavigationStack.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 19.07.24.
//

import SwiftUI

struct RoutedNavigationStack<Content: View>: View {
    @StateObject var router = AppRouter()
    var content: () -> Content
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .routerNavigationDestinations()
        }
        .environmentObject(router)
        .dataModelContainer()
    }
}

