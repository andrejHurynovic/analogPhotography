//
//  analogPhotographyApp.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI

@main
struct analogPhotographyApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(DataContainer().getContainer())
    }
}
