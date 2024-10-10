//
//  FilmRollRollPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmRollPickerSheet: View {
    @Binding var isPresented: Bool
    @Binding var picked: FilmRoll?
    
    var body: some View {
        FilmRollsGenericView { filmRolls in
            ModelPickerSheet(isPresented: $isPresented,
                             selectedElement: $picked,
                             elements: filmRolls) { filmRoll in
                FilmRollView(roll: filmRoll)
            }
        }
        
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    @Previewable @State var picked: FilmRoll?
    
    NavigationStackPreview {
        Form {
            Button("Select filmRoll") {
                isPresented = true
            }
            if let picked = picked {
                FilmRollView(roll: picked)
            } else {
                Text("No selected filmRoll")
            }
        }
        .sheet(isPresented: $isPresented) {
            FilmRollPickerSheet(isPresented: $isPresented, picked: $picked)
        }
    }
    
}
