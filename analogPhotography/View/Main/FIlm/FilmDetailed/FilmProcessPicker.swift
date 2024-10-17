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
        MenuModelPicker(sort: [.init(\FilmProcess.name)],
                        selectedValue: $filmProcess,
                        title: "Process") { filmProcesses in
            ForEach(filmProcesses) { Text($0.name).tag($0 as FilmProcess?) }
        }
    }
}

#Preview {
    @Previewable @State var filmProcess: FilmProcess?
    
    Form {
        FilmProcessPicker(filmProcess: $filmProcess)
    }
    .dataModelContainer()
}

