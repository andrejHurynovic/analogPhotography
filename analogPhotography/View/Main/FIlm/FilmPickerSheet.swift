//
//  FilmPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmPickerSheet: View {
    @Binding var isPresented: Bool
    @Binding var picked: Film?
    
    var body: some View {
        FilmsGenericView { films in
            ModelPickerSheet(isPresented: $isPresented,
                             selectedElement: $picked,
                             elements: films) { film in
                FilmView(film: film)
            }
        }
        
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    @Previewable @State var picked: Film?
    
    NavigationStackPreview {
        Form {
            Button("Select film") {
                isPresented = true
            }
            if let picked = picked {
                FilmView(film: picked)
            } else {
                Text("No selected film")
            }
        }
        .sheet(isPresented: $isPresented) {
            FilmPickerSheet(isPresented: $isPresented, picked: $picked)
        }
    }
    
}
