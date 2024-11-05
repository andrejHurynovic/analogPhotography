//
//  PhotoDetailedContent.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.10.2024.
//

import SwiftUI
import SwiftData

struct PhotoDetailedContent: View {
    @Bindable var photo: Photo
    
    var body: some View {
        map
        properties
        NoteView(note: $photo.note)
    }
    
    @ViewBuilder var map: some View {
        Section("Map") {
            MapPicker(viewModel: MapPickerViewModel(selectedLocation: $photo.location),
                      otherItems: [],
                      favoriteItems: [])
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    @ViewBuilder var properties: some View {
        Section("Properties") {
            OptionalDatePicker(date: $photo.date)
            aperturePicker
            ShutterSpeedPicker(value: $photo.shutterSpeed)
        }
    }
    
    @ViewBuilder var aperturePicker: some View {
        TextFieldForm(title: "Aperture",
                      placeholder: "f/2.8",
                      text: $photo.aperture.prefixed(with: "f/"))
        .keyboardType(.numberPad)
    }
}
