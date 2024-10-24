//
//  FilmScannerBarcodeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.10.24.
//

import SwiftUI
import SwiftData

extension FilmScannerView {
    struct FilmScannerBarcodeView: View {
        private var state: FilmScannerBarcodeViewState
        @Binding var bottomMenuState: FilmScannerMenuState
        private var filteredFilms: [FilmType] = []
        
        var selectedFilm: Binding<FilmType?>?
        @EnvironmentObject var manager: ModelPickerSheetManager
        
        init(filterDXBarcode: String?,
             bottomMenuState: Binding<FilmScannerMenuState>,
             selectedFilm: Binding<FilmType?>?,
             modelContext: ModelContext) {
            self._bottomMenuState = bottomMenuState
            self.selectedFilm = selectedFilm
            
            guard let filterDXBarcode = filterDXBarcode else {
                state = .noBarcode;
                return
            }
            guard let films = try? modelContext.fetch(FetchDescriptor<FilmType>()) else {
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
            case .noBarcode:
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
                        NavigationLink(value: Route.film(film as! Film)) {
                            filmView(for: film)
                        }
                    }
                    
                    
                }
            }
            
        }
        
        @ViewBuilder func filmView(for film: FilmType) -> some View {
            FilmView(film: film)
                .plainBackgroundStyle()
        }

    }
    
    enum FilmScannerBarcodeViewState {
        case noBarcode
        case dbError
        case noFilteredFilms
        case showing
    }
}
