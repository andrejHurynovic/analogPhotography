//
//  FilmRollMinimizedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 18.10.2024.
//

import SwiftUI

struct FilmRollMinimizedView: View {
    @Bindable var filmRoll: FilmRoll
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(filmRoll.uiDescription)
                Spacer()
                Text(filmRoll.capacityDescription)
                    .bold()
            }
            .monospaced()
            FilmRollFinishButton(filmRoll: filmRoll, checkIsOfferToFinish: true)
                .buttonStyle(CellButtonStyle())
        }
    }
}
