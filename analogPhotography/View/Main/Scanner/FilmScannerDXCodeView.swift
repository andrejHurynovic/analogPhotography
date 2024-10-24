//
//  FilmScannerDXCodeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 6.10.24.
//

import SwiftUI

extension FilmScannerView {
    struct FilmScannerDXCodeView: View {
        var dxCode: DXCode?
        
        var selectedFilm: Binding<FilmType?>?

        var body: some View {
            if let dxCode = dxCode {
                DXCodeView(dxCode: dxCode)
                    .plainBackgroundStyle()
                    .padding(.horizontal)
                    .aspectRatio(contentMode: .fit)
                NavigationLink(value: Route.film(Film(from: dxCode), selectedFilm as! Binding<Film?>?)) {
                    DXCodeFilmView(dxCode: dxCode)
                        .plainBackgroundStyle()
                }
            } else {
                Text("No DX codes detected.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .plainBackgroundStyle()
            }
        }
    }
}
