//
//  PhotosSliderView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 28.10.2024.
//

import SwiftUI
import SwiftData

struct PhotosSliderView: View {
    var photos: [Photo]
    @State var activeID: PersistentIdentifier? = nil
    @State var isPagingSliderPresented: Bool = false
    
    var body: some View {
        if isPagingSliderPresented {
            Button {
                withAnimation {
                    isPagingSliderPresented = false
                }
            } label: {
                Image(systemName: "xmark.circle")
            }

            PagingSlider(items: photos, activeID: $activeID) { photo in
                PhotoDetailedContent(photo: photo)
            } titleContent: { photo in
                PhotoView(photo: photo)
            }
        } else {
            ForEach(photos) { photo in
                Button {
                    activeID = photo.id
                    withAnimation {
                        isPagingSliderPresented = true
                    }
                } label: {
                    PhotoView(photo: photo)
                }
            }
        }
    }
}
