//
//  FilmRollView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.07.24.
//

import SwiftUI

struct FilmRollRowView: View {
    @Bindable var roll: FilmRoll
    
    var body: some View {
        VStack(alignment: .leading) {
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
}

#Preview {
    ModelPreview { filmRoll in
        List {
            FilmRollRowView(roll: filmRoll)
        }
    }
}
