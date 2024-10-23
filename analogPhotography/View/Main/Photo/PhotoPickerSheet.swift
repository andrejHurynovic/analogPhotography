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
    @StateObject var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            PhotosGenericView { photos in
                ModelPickerSheet(isPresented: $isPresented,
                                 selectedElement: $picked,
                                 elements: photos) { photo in
                    PhotoView(photo: photo)
                }
            }
            .routerNavigationDestinations()
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    @Previewable @State var picked: Photo?
    
    RoutedNavigationStack {
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
