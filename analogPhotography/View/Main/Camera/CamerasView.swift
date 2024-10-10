//
//  CamerasView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.07.24.
//

import SwiftUI
import SwiftData

struct CamerasView: View {
    
    var body: some View {
        ModelsView(sort: [SortDescriptor(\Camera.name)],
                   navigationTitle: "Cameras") { cameras in
            List(cameras) { camera in
                CameraView(camera: camera)
            }
        }
    }
}

#Preview {
    NavigationStackPreview {
        CamerasView()
            .routerNavigationDestinations()
    }
}
