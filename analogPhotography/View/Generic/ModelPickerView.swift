//
//  ModelPickerView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 7.10.24.
//

import SwiftUI
import SwiftData

struct ModelPickerView<Element: PersistentModel, Content: View>: View {
    let descriptor: FetchDescriptor<Element>
    @Binding var selectedElement: Element?
    @ViewBuilder let content: (Element) -> Content
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        QueryView(descriptor: descriptor) { element in
            Button(action: {
                withAnimation {
                    selectedElement = element
                    router.navigateBack()
                }
            }, label: {
                content(element)
            })
            .buttonStyle(.plain)
        }
    }
}

fileprivate struct ModelPickerViewPreview: View {
    @State var film: Film?
    
    var body: some View {
        List {
            Section("Picked") {
                if let film = film {
                    FilmCellView(film: film)
                }
            }
            ModelPickerView(descriptor: FetchDescriptor<Film>(),
                            selectedElement: $film) { film in
                FilmCellView(film: film)
            }
        }
    }
}

#Preview {
    ModelPickerViewPreview()
        .dataModelContainer()
}
