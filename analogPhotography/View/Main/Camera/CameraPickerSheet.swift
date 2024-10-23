//
//  CameraPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct CameraPickerSheet: View {
    @EnvironmentObject var manager: ModelPickerSheetManager
    @Binding var picked: Camera?
    @StateObject var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            CamerasGenericView(selectedCamera: $picked) { cameras in
                ModelPickerSheet(isPresented: $manager.isPresented,
                                 selectedElement: $picked,
                                 elements: cameras) { camera in
                    CameraView(camera: camera)
                }
            }
            .routerNavigationDestinations()
        }
        .environmentObject(router)
    }
}

#Preview {
    @Previewable @State var manager = ModelPickerSheetManager()
    @Previewable @State var picked: Camera?
    
    RoutedNavigationStack {
        Form {
            Button("Select camera") {
                manager.isPresented = true
            }
            if let picked = picked {
                CameraView(camera: picked)
            } else {
                Text("No selected camera")
            }
        }
        .sheet(isPresented: $manager.isPresented) {
            CameraPickerSheet(picked: $picked)
                .environmentObject(manager)
        }
    }
    
}
