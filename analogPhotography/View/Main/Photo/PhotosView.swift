//
//  PhotosView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.07.24.
//

import SwiftUI

struct PhotosView: View {
    var body: some View {
        PhotosGenericView { photos in
            List(photos) { photo in
                NavigationLink(value: Route.photo(photo)) {
                    PhotoView(photo: photo)
                }
            }
        }
    }
}

#Preview {
    NavigationStackPreview {
        PhotosView()
    }
}
