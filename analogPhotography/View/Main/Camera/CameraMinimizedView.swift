//
//  CameraMinimizedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 23.10.2024.
//

import SwiftUI

struct CameraMinimizedView: View {
    @Bindable var camera: Camera
    
    var body: some View {
        VStack(alignment: .leading) {
            name
            note
        }
    }
    
    var name: some View {
        Text(camera.name)
            .font(.title2)
            .fontWeight(.bold)
    }
    @ViewBuilder var note: some View {
        if camera.note != "" {
            Text(camera.note)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}
