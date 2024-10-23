//
//  CameraFilmRollView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 23.10.2024.
//

import SwiftUI

struct CameraFilmRollView: View {
    @Bindable var camera: Camera
    
    @State var selectedFilm: Film?
    @StateObject var pickerManager = ModelPickerSheetManager()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            if let currentFilmRoll = camera.currentFilmRoll {
                FilmRollMinimizedView(filmRoll: currentFilmRoll)
                    .contextMenu {
                        changeFilmButton
                        deleteFilmButton
                    }
            } else {
                selectFilmButton
                .buttonStyle(CellButtonStyle())
            }
        }
        .sheet(isPresented: $pickerManager.isPresented) { filmSelected(with: selectedFilm) } content: {
            FilmPickerSheet(picked: $selectedFilm)
                .environmentObject(pickerManager)
        }
        .animation(.default, value: camera.currentFilmRoll)
    }
    
    var changeFilmButton: some View {
        Button("Change film") {
            pickerManager.isPresented = true
        }
    }
    var deleteFilmButton: some View {
        DeleteButton {
            camera.deleteCurrentFilmRoll(in: modelContext)
        }
    }
    var selectFilmButton: some View {
        Button("Select new film") {
            pickerManager.isPresented = true
        }
    }
    func filmSelected(with selectedFilm: Film?) {
        guard let selectedFilm = selectedFilm else { return }
        if let _ = camera.currentFilmRoll {
            camera.changeCurrentFilmRoll(film: selectedFilm, in: modelContext)
        } else {
            camera.addFilmRoll(film: selectedFilm)
        }
        self.selectedFilm = nil
    }
}
