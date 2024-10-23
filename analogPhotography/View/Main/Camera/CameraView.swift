//
//  CameraView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.07.24.
//

import SwiftUI

struct CameraView: View {
    @Bindable var camera: Camera
    
    var body: some View {
        VStack(alignment: .leading) {
            CameraMinimizedView(camera: camera)
            CameraFilmRollView(camera: camera)
        }
    }
    
}

#Preview {
    ModelPreview { camera in
        Form {
            CameraView(camera: camera)
        }
    }
}
