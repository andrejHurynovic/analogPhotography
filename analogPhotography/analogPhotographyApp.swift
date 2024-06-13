//
//  analogPhotographyApp.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI
import SwiftData

@main
struct analogPhotographyApp: App {
    
//    init() {
//        if try! sharedModelContainer.mainContext.fetchCount(FetchDescriptor<FilmFormat>()) == 0 {
//            sharedModelContainer.mainContext.insert(FilmFormat.getDefaults())
//        }
//        if try! sharedModelContainer.mainContext.fetchCount(FetchDescriptor<FilmProcess>()) == 0 {
//            sharedModelContainer.mainContext.insert(FilmProcess.getDefaults())
//        }
//    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Camera.self,
            Photo.self,
            Film.self,
            FilmType.self,
            FilmFormat.self,
            FilmProcess.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
