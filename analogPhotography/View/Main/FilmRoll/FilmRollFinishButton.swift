//
//  FilmRollFinishButton.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 23.10.2024.
//

import SwiftUI

struct FilmRollFinishButton: View {
    @Bindable var filmRoll: FilmRoll
    let checkIsOfferToFinish: Bool
    
    @State var showAlert: Bool = false
    
    var body: some View {
        if !filmRoll.finished && (!checkIsOfferToFinish || filmRoll.isOfferToFinish == true) {
            Button("Finish film") {
                showAlert = true
            }
            .alert("Are you sure you want to finish the film?", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {  }
                Button("Finish film") { filmRoll.finished = true }
            }
        }
    }
}
