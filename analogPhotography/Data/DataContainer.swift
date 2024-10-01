//
//  DataContainer.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 6.07.24.
//

import SwiftData

@MainActor
class DataContainer {
    private let container: ModelContainer
    
    init() {
        let schema = Schema([
            Camera.self,
            Photo.self,
            FilmRoll.self,
            Film.self,
            FilmFormat.self,
            FilmProcess.self
        ])
        
        do {
#if targetEnvironment(simulator)
            // If running in the simulator, configure the container to use in-memory storage only.
            // This means data won't be saved between sessions.
            self.container = try ModelContainer(for: schema,
                                                configurations: ModelConfiguration(schema: schema, isStoredInMemoryOnly: true))
            PreviewDataProvider.insertPreviewData(in: container)
#else
            //If not running in the simulator, configure the container to use persistent storage.
            self.container = try ModelContainer(for: schema,
                                                configurations: ModelConfiguration(schema: schema, isStoredInMemoryOnly: true))
#endif
        } catch {
            fatalError("Failed to create persistentContainer: \(error.localizedDescription)")
        }
    }
    
    func getContainer() -> ModelContainer { container }
    
}
