//
//  CameraDetailedViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 18.07.24.
//

import SwiftUI
import SwiftData

final class CameraDetailedViewModel: ObservableObject {
    @Published var camera: Camera
    @Published var viewState: ViewState
    
    init(camera: Camera? = nil) {
        if let camera = camera {
            self.camera = camera
            self.viewState = .showing
        } else {
            self.camera = Camera()
            self.viewState = .creating
        }
    }
    
    func delete(in modelContext: ModelContext) {
        modelContext.delete(camera)
    }
    func insert(in modelContext: ModelContext) {
        modelContext.insert(camera)
    }
}
