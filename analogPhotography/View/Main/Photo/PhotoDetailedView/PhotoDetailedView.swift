//
//  PhotoDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.06.24.
//

import SwiftUI
import SwiftData

struct PhotoDetailedView: View {
    @Bindable var photo: Photo
    var selectedPhoto: Binding<Photo?>?
    @State var apertureText: String = ""

    var body: some View {
        DetailedView(model: photo, selectedModel: selectedPhoto,
                     viewModelType: PhotoDetailedViewModel.self) { viewModel, viewModelBinding in
            Form {
                map
                properties
                NoteView(note: $photo.note)
            }
        }
        
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
                          text: $apertureText)
            .keyboardType(.numberPad)
            .textFieldPrefix(prefix: "f/", text: $photo.aperture, textFieldText: $apertureText)
    }
}

#Preview {
        ModelPreview<Photo, PhotoDetailedView> { photo in
            PhotoDetailedView(photo: photo)
        }
}
