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
    
    var body: some View {
        DetailedView(model: photo, selectedModel: selectedPhoto,
                     viewModelType: PhotoDetailedViewModel.self) { viewModel, viewModelBinding in
            Form {
                PhotoDetailedContent(photo: photo)
            }
        }
        
    }
}

#Preview {
        ModelPreview<Photo, PhotoDetailedView> { photo in
            PhotoDetailedView(photo: photo)
        }
}
