//
//  PhotoDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.06.24.
//

import SwiftUI
import SwiftData
import MapKit

struct PhotoDetailedView: View {
    
    @Bindable var photo: Photo
    @State var apertureText: String = ""
    
    var body: some View {
        List {
            properties
            NoteView(note: $photo.note)
        }
    }
    
    var properties: some View {
        Section("Характеристики") {
            DatePicker("Дата", selection: $photo.date)
            aperturePicker
        }
    }
    
    var aperturePicker: some View {
        TextFieldFormView(title: "Диафрагма",
                          placeholder: "f/",
                          text: $apertureText,
                          editState:  .constant(true))
            .keyboardType(.numberPad)
            .textFieldPrefix(prefix: "f/", text: $photo.aperture, textFieldText: $apertureText)
    }
}

#Preview {
    let schema = Schema([
        Film.self,
        Photo.self
    ])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    return NavigationStack {
        let container = try! ModelContainer(for: schema,
                                            configurations: config)
        let previewPhoto = Photo(film: Film(name: "Kodak Gold", note: "", photos: []),
                                 date: .now,
                                 locationLatitude: 53.912785,
                                 locationLongitude: 27.629385,
                                 aperture: "",
                                 shutterSpeed: "1/100",
                                 image: nil,
                                 note: "Кажется, получилось неплохо")
        PhotoDetailedView(photo: previewPhoto)
            .modelContainer(container)
    }
}
