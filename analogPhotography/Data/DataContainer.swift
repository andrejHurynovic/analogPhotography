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
            Film.self,
            FilmType.self,
            FilmFormat.self,
            FilmProcess.self
        ])
        
        do {
#if targetEnvironment(simulator)
            // If running in the simulator, configure the container to use in-memory storage only.
            // This means data won't be saved between sessions.
            self.container = try ModelContainer(for: schema,
                                                configurations: ModelConfiguration(schema: schema, isStoredInMemoryOnly: true))
            insertPreviewData()
#else
            //If not running in the simulator, configure the container to use persistent storage
            self.container = try ModelContainer(for: schema,
                                                configurations: ModelConfiguration(schema: schema, isStoredInMemoryOnly: false))
#endif
        } catch {
            fatalError("Failed to create persistentContainer: \(error.localizedDescription)")
        }
    }
    
    func getContainer() -> ModelContainer { container }
    
    private func insertPreviewData() {
        self.container.mainContext.insert(Camera.samples())
    }
}
