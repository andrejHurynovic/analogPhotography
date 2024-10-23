//
//  FilmRollView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.07.24.
//

import SwiftUI

struct FilmRollView: View {
    @Bindable var filmRoll: FilmRoll
    
    var body: some View {
        VStack(alignment: .leading) {
            name
            creationDate
        }
    }
    
    var name: some View {
        Text(filmRoll.uiDescription)
            .font(.title2)
            .fontWeight(.bold)
    }
    
    var creationDate: some View {
        Text(filmRoll.creationDate.formatted())
            .font(.caption)
            .foregroundStyle(.gray)
    }
}

#Preview {
    ModelPreview { filmRoll in
        List {
            FilmRollView(filmRoll: filmRoll)
        }
    }
}
