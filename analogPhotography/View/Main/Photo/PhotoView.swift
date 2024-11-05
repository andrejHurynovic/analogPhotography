//
//  PhotoView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct PhotoView: View {
    @Bindable var photo: Photo
    
    var body: some View {
        VStack(alignment: .leading) {
            firstLine
            secondLine
        }
        .foregroundStyle(Color.random())
    }
    
    var firstLine: some View {
        HStack {
            Text("#\(photo.order).")
            if let date = photo.date {
                Text(date.formatted(date: .numeric, time: .standard))
            }
        }
        .font(.title2)
        .bold()
    }
    var secondLine: some View {
        HStack {
            if let locationDescription = photo.locationDescription {
                Text(locationDescription)
            }
            if let aperture = photo.aperture {
                Text(aperture)
            }
            if !photo.shutterSpeed.isEmpty {
                Text(photo.shutterSpeed)
            }
        }
        .monospaced()
        .font(.callout)
    }
}

#Preview {
    ModelPreview { photo in
        Form {
            PhotoView(photo: photo)
        }
    }
}
