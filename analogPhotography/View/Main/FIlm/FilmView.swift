//
//  FilmView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.10.24.
//

import SwiftUI

struct FilmView<FilmType: FilmProtocol>: View {
    @Bindable var film: FilmType
    
    var body: some View {
        VStack(alignment: .leading) {
            name
            HStack {
                parameters
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    var name: some View {
        Text(film.uiDescription)
            .font(.title2)
            .fontWeight(.bold)
    }
    
    @ViewBuilder var parameters: some View {
        if let capacity = film.capacity {
            Text("\(capacity) exposures")
        }
        if let speed = film.speed {
            Text("\(speed) ISO")
        }
        if let format = film.format {
            Text(format.uiDescription)
        }
        if let process = film.process{
            Text(process.uiDescription)
        }
    }
}

#Preview {
    ModelPreview { film in
        FilmView(film: film as Film)
    }
}
