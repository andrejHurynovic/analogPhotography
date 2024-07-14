//
//  ContentView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath, root: {
            CamerasView()
        })
    }

}

#Preview {
    ContentView()
        .modelContainer(DataContainer().getContainer())
}
