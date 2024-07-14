//
//  CamerasView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.07.24.
//

import SwiftUI
import SwiftData

struct CamerasView: View {
    @Query(sort: [SortDescriptor(\Camera.name)]) var cameras: [Camera]
    var body: some View {
        List(cameras) { camera in
            CameraView(camera: camera)
        }
        .navigationTitle("Cameras")
        .overlay { contentUnavailable }
    }
    
    @ViewBuilder var contentUnavailable: some View {
        if cameras.isEmpty == true {
            ContentUnavailableView(label: {
                Label("No cameras", systemImage: "camera.fill")
            }, description: {
                Text("You're cameras will appear here.")
            }, actions: {
                Button("Add camera") {
                    
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        CamerasView()
    }
    .modelContainer(DataContainer().getContainer())
}
