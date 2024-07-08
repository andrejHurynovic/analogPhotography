//
//  ContentView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {

        }
    }

}

#Preview {
    ContentView()
        .modelContainer(DataContainer().getContainer())
}
