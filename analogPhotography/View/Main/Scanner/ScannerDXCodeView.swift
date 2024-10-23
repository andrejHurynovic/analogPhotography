//
//  ScannerDXCodeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 6.10.24.
//

import SwiftUI

extension ScannerFilmPickerView {
    struct ScannerDXCodeView: View {
        var dxCode: DXCode?
        
        var selectedFilm: Binding<Film?>?

        var body: some View {
            if let dxCode = dxCode {
                DXCodeView(dxCode: dxCode)
                    .plainBackgroundStyle()
                    .padding(.horizontal)
                    .aspectRatio(contentMode: .fit)
                NavigationLink(value: Route.film(Film(from: dxCode), selectedFilm)) {
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
