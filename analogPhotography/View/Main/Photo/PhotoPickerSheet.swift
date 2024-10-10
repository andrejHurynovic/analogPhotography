//
//  PhotoRollPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct PhotoPickerSheet: View {
    @Binding var isPresented: Bool
    @Binding var picked: Photo?
    
    var body: some View {
        PhotosGenericView { photos in
            ModelPickerSheet(isPresented: $isPresented,
                             selectedElement: $picked,
                             elements: photos) { photo in
                PhotoView(photo: photo)
            }
        }
        
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    @Previewable @State var picked: Photo?
    
    NavigationStackPreview {
        Form {
            Button("Select photo") {
                isPresented = true
            }
            if let picked = picked {
                PhotoView(photo: picked)
            } else {
                Text("No selected photo")
            }
        }
        .sheet(isPresented: $isPresented) {
            PhotoPickerSheet(isPresented: $isPresented, picked: $picked)
        }
    }
    
}
