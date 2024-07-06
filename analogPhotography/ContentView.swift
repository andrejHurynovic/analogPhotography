//
//  ContentView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
    var body: some View {
        NavigationStack {
            List {
                Text("SUS")
            }

        }
    }

}

#Preview {
    ContentView()
        .modelContainer(DataContainer().getContainer())
}
