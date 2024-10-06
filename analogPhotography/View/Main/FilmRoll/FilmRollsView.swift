//
//  FilmRollsView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.07.24.
//

import SwiftUI
import SwiftData

struct FilmRollsView: View {
    @Query var filmRolls: [FilmRoll]
    
    var body: some View {
        List(filmRolls) { filmRoll in
            FilmRollCellView(roll: filmRoll)
        }
        .navigationTitle("Film rolls")
        .overlay { contentUnavailable }
    }
    
    @ViewBuilder var contentUnavailable: some View {
        if filmRolls.isEmpty == true {
            ContentUnavailableView(label: {
                Label("No films", systemImage: "film.stack")
            }, description: {
                Text("You're films will appear here.")
            }, actions: {
                AddModelButton {  }
            })
        }
    }
}

#Preview {
    NavigationStackPreview {
        FilmRollsView()
            .modelContainer(DataContainer().getContainer())
    }
}
