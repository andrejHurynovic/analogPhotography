//
//  ScannerBarcodeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.10.24.
//

import SwiftUI
import SwiftData

extension ScannerPickerView {
    struct ScannerBarcodeView: View {
        private var state: ScannerFilmsViewState
        private var filteredFilms: [Film] = []
        
        init(filterDXBarcode: String?, modelContext: ModelContext) {
            guard let filterDXBarcode = filterDXBarcode else {
                state = .noDXBarcode;
                return
            }
            guard let films = try? modelContext.fetch(FetchDescriptor<Film>()) else {
                state = .dbError;
                return
            }
            filteredFilms = films.filter { film in film.dxBarcodes.contains(filterDXBarcode) }
            guard filteredFilms.isEmpty == false else {
                state = .noFilteredFilms;
                return
            }
            state = .showing
        }
        
        var body: some View {
            switch state {
            case .noDXBarcode:
                Text("No barcode detected.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .plainBackgroundStyle()
            case .dbError:
                Text("Database error.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .plainBackgroundStyle()
                
            case .noFilteredFilms:
                Text("No films associated with this barcode.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .plainBackgroundStyle()
                
            case .showing:
                ForEach(filteredFilms) { film in
                    NavigationLink(value: Route.film(film)) {
                        FilmView(film: film)
                            .plainBackgroundStyle()
                    }
                    
                }
            }
            
        }
    }
    
    enum ScannerFilmsViewState {
        case noDXBarcode
        case dbError
        case noFilteredFilms
        case showing
    }
}

#Preview {
    NavigationStackPreview {
        ScannerPickerView()
    }
}
