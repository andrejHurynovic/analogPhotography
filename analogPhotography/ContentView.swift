//
//  ContentView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var films: [FilmType]
    @Query(sort: [SortDescriptor(\FilmFormat.outdated),
                  SortDescriptor(\FilmFormat.name)])
    private var filmFormats: [FilmFormat]

    var body: some View {
        NavigationStack {
            List {
                Button("sus") {
                    modelContext.insert(FilmFormat.getDefaults())
                }
                ForEach(filmFormats) { format in
                    Text(format.name)
                }
            }

        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: FilmType.self, inMemory: true)
}
