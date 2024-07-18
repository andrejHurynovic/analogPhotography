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
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        List(cameras) { camera in
            CameraRowView(camera: camera)
        }
        .navigationTitle("Cameras")
        .toolbar(content: {
            NavigationLink("Add", value: Route.camera(Camera()))
        })
        .overlay { contentUnavailable }
    }
    
    @ViewBuilder var contentUnavailable: some View {
        if cameras.isEmpty == true {
            ContentUnavailableView(label: {
                Label("No cameras", systemImage: "camera.fill")
            }, description: {
                Text("You're cameras will appear here.")
            }, actions: {
                NavigationLink("Add camera", value: Route.camera(Camera()))
            })
        }
    }
}

#Preview {
    NavigationStack {
        CamerasView()
            .routerNavigationDestinations()
    }
    .modelContainer(DataContainer().getContainer())
}
