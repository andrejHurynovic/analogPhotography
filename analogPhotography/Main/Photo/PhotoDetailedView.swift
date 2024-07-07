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
            map
            properties
            NoteView(note: $photo.note)
        }
    }
    
    @ViewBuilder var map: some View {
        Section("Местоположение") {
            MapPicker(viewModel: MapPickerViewModel(selectedLocation: $photo.location), 
                      otherItems: [],
                      favoriteItems: [])
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    @ViewBuilder var properties: some View {
        Section("Характеристики") {
//            DatePicker("Дата", selection: $photo.date)
            aperturePicker
            shutterSpeedPicker
        }
    }
    
    @ViewBuilder var aperturePicker: some View {
        TextFieldFormView(title: "Диафрагма",
                          placeholder: "f/2.8",
                          text: $apertureText,
                          editState:  .constant(true))
            .keyboardType(.numberPad)
            .textFieldPrefix(prefix: "f/", text: $photo.aperture, textFieldText: $apertureText)
    }
    @ViewBuilder var shutterSpeedPicker: some View {
        TextFieldFormView(title: "Скорость затвора",
                          placeholder: "1/100",
                          text: $photo.shutterSpeed,
                          editState: .constant(true))
        DiscreteSlider(value: $photo.shutterSpeed, values: Constants.Photo.shutterSpeeds)
    }
}

#Preview {
    ModelPreview { photo in
        PhotoDetailedView(photo: photo)
    }
}
