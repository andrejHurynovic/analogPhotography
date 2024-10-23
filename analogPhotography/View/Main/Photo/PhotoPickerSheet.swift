//
//  PhotoRollPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct PhotoPickerSheet: View {
    @EnvironmentObject var manager: ModelPickerSheetManager
    @Binding var picked: Photo?
    @StateObject var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            PhotosGenericView(selectedPhoto: $picked) { photos in
                ModelPickerSheet(isPresented: $manager.isPresented,
                                 selectedElement: $picked,
                                 elements: photos) { photo in
                    PhotoView(photo: photo)
                }
            }
            .routerNavigationDestinations()
        }
        .environmentObject(router)
    }
}

#Preview {
    @Previewable @State var manager = ModelPickerSheetManager()
    @Previewable @State var picked: Photo?
    
    RoutedNavigationStack {
        Form {
            Button("Select photo") {
                manager.isPresented = true
            }
            if let picked = picked {
                PhotoView(photo: picked)
            } else {
                Text("No selected photo")
            }
        }
        .sheet(isPresented: $manager.isPresented) {
            PhotoPickerSheet(picked: $picked)
                .environmentObject(manager)
        }
    }
    
}
