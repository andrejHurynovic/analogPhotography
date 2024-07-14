//
//  FilmsView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.07.24.
//

import SwiftUI
import SwiftData

struct FilmsView: View {
    @Query var filmRolls: [FilmRoll]
    
    var body: some View {
        let _ = Self._printChanges()
        List(filmRolls) { filmRoll in
            FilmRollView(roll: filmRoll)
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
                Button("Add film") {
                    
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        FilmsView()
            .modelContainer(DataContainer().getContainer())
    }
}

struct FilmRollView: View {
    @Bindable var roll: FilmRoll
    
    var body: some View {
        VStack {
            name
            creationDate
        }
    }
    
    var name: some View {
        Text(roll.name ?? roll.film?.name ?? "")
            .font(.title2)
            .fontWeight(.bold)
    }
    
    var creationDate: some View {
        Text(roll.creationDate.formatted())
            .font(.caption)
            .foregroundStyle(.gray)
    }
//    var progress: some View {
//        ProgressView
//    }
}

//#Preview {
//    ModelPreview { film in
//        List {
//            FilmView(film: film)
//        }
//    }
//}
