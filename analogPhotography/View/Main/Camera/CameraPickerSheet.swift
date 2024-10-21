//
//  CameraPickerSheet.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct CameraPickerSheet: View {
    @Binding var isPresented: Bool
    @Binding var picked: Camera?
    
    var body: some View {
        NavigationStack {
            CamerasGenericView { cameras in
                ModelPickerSheet(isPresented: $isPresented,
                                 selectedElement: $picked,
                                 elements: cameras) { camera in
                    CameraView(camera: camera)
                }
            }
            .routerNavigationDestinations()
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    @Previewable @State var picked: Camera?
    
    RoutedNavigationStack {
        Form {
            Button("Select camera") {
                isPresented = true
            }
            if let picked = picked {
                CameraView(camera: picked)
            } else {
                Text("No selected camera")
            }
        }
        .sheet(isPresented: $isPresented) {
            CameraPickerSheet(isPresented: $isPresented, picked: $picked)
        }
    }
    
}
