//
//  ScannerFilmsView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.10.24.
//

import SwiftUI
import SwiftData

extension ScannerView {
    struct ScannerFilmsView: View {
        private var state: ScannerFilmsViewState
        private var filteredFilms: [Film] = []
        
        
        init(filterDXBarcodes: Set<String>, modelContext: ModelContext) {
            guard filterDXBarcodes.isEmpty == false else {
                state = .noDXBarcodes;
                return
            }
            guard let films = try? modelContext.fetch(FetchDescriptor<Film>()) else {
                state = .dbError;
                return
            }
            filteredFilms = films.filter { film in !film.dxBarcodes.isDisjoint(with: filterDXBarcodes) }
            guard filteredFilms.isEmpty == false else {
                state = .noFilteredFilms;
                return
            }
            state = .showing
        }
        
        var body: some View {
            switch state {
            case .noDXBarcodes:
                Text("No barcodes detected.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            case .dbError:
                Text("Database error.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            case .noFilteredFilms:
                Text("No films associated with this barcode.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            case .showing:
                ForEach(filteredFilms) { film in
                    NavigationLink(value: Route.film(film)) {
                        FilmCellView(film: film)
                            .backgroundStyle()
                    }
                    
                }
            }
            
        }
    }
    
    enum ScannerFilmsViewState {
        case noDXBarcodes
        case dbError
        case noFilteredFilms
        case showing
    }
}
