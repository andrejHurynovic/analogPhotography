//
//  ScannerBarcodeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.10.24.
//

import SwiftUI
import SwiftData

extension ScannerFilmPickerView {
    struct ScannerBarcodeView: View {
        private var state: ScannerFilmsViewState
        @Binding var bottomMenuState: ScannerViewBottomMenuState
        private var filteredFilms: [Film] = []
        
        var selectedFilm: Binding<Film?>?
        @EnvironmentObject var manager: ModelPickerSheetManager
        
        init(filterDXBarcode: String?,
             bottomMenuState: Binding<ScannerViewBottomMenuState>,
             selectedFilm: Binding<Film?>?,
             modelContext: ModelContext) {
            self._bottomMenuState = bottomMenuState
            self.selectedFilm = selectedFilm
            
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
                VStack {
                    Text("No films associated with this barcode.")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .plainBackgroundStyle()
                    Button("Try to create new film from DXCode") {
                        bottomMenuState = .dxCode
                    }
                    .buttonStyle(CellButtonStyle())
                }
                
            case .showing:
                ForEach(filteredFilms) { film in
                    if let selectedFilm = selectedFilm {
                        Button {
                            selectedFilm.wrappedValue = film
                            manager.isPresented = false
                        } label: {
                            filmView(for: film)
                        }
                    } else {
                        NavigationLink(value: Route.film(film)) {
                            filmView(for: film)
                        }
                    }
                    
                    
                }
            }
            
        }
        
        @ViewBuilder func filmView(for film: Film) -> some View {
            FilmView(film: film)
                .plainBackgroundStyle()
        }

    }
    
    enum ScannerFilmsViewState {
        case noDXBarcode
        case dbError
        case noFilteredFilms
        case showing
    }
}
