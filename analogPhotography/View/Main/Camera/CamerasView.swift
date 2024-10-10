//
//  CamerasView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.10.2024.
//

import SwiftUI

struct CamerasView: View {
    var body: some View {
        CamerasGenericView { cameras in
            List(cameras) { camera in
                NavigationLink(value: Route.camera(camera)) {
                    CameraView(camera: camera)
                }
            }
        }
    }
}

#Preview {
    NavigationStackPreview {
        CamerasView()
    }
}
