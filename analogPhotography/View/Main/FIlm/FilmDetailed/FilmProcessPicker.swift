//
//  FilmProcessPicker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 23.07.24.
//

import SwiftUI

struct FilmProcessPicker: View {
    @Binding var filmProcess: FilmProcess?
    
    var body: some View {
        ModelPicker(sort: [.init(\FilmProcess.name)], selectedValue: $filmProcess, title: "Process") { filmProcesses in
            ForEach(filmProcesses) { Text($0.name).tag($0 as FilmProcess?) }
        }
    }
}

#Preview {
    struct FilmProcessPickerPreview: View {
        @State var filmProcess: FilmProcess?
        
        var body: some View {
            Form {
                FilmProcessPicker(filmProcess: $filmProcess)
            }
            .dataModelContainer()
        }
    }
    return FilmProcessPickerPreview()
}

