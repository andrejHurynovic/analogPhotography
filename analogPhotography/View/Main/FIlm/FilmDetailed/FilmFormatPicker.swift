//
//  FilmFormatPicker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 22.07.24.
//

import SwiftUI

struct FilmFormatPicker: View {
    @Binding var filmFormat: FilmFormat?
    
    var body: some View {
        ModelPicker(sort: [.init(\FilmFormat.name)], selectedValue: $filmFormat, title: "Format") { filmFormats in
            let notOutdated = filmFormats.filter { $0.outdated == false }
            let outdated = filmFormats.filter { $0.outdated == true }
            ForEach(notOutdated) { Text($0.uiDescription).tag($0 as FilmFormat?) }
            Section("Outdated") { ForEach(outdated) { Text($0.uiDescription).tag($0 as FilmFormat?) } }
        }
    }
}

#Preview {
    struct FilmFormatPickerPreview: View {
        @State var filmFormat: FilmFormat?
        
        var body: some View {
            Form {
                FilmFormatPicker(filmFormat: $filmFormat)
            }
            .modelContainer(DataContainer().getContainer())
        }
    }
    return FilmFormatPickerPreview()
}
