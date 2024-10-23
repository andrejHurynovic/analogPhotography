//
//  FilmRollRollPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct FilmRollPickerSheet: View {
    @EnvironmentObject var manager: ModelPickerSheetManager
    @Binding var picked: FilmRoll?
    @StateObject var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            FilmRollsGenericView(selectedFilmRoll: $picked) { filmRolls in
                ModelPickerSheet(isPresented: $manager.isPresented,
                                 selectedElement: $picked,
                                 elements: filmRolls) { filmRoll in
                    FilmRollView(roll: filmRoll)
                }
            }
            .routerNavigationDestinations()
        }
        .environmentObject(router)
    }
}

#Preview {
    @Previewable @State var manager = ModelPickerSheetManager()
    @Previewable @State var picked: FilmRoll?
    
    RoutedNavigationStack {
        Form {
            Button("Select filmRoll") {
                manager.isPresented = true
            }
            if let picked = picked {
                FilmRollView(roll: picked)
            } else {
                Text("No selected filmRoll")
            }
        }
        .sheet(isPresented: $manager.isPresented) {
            FilmRollPickerSheet(picked: $picked)
                .environmentObject(manager)
        }
    }
    
}
