//
//  ModelPreview.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 5.07.24.
//

import SwiftUI
import SwiftData

struct ModelPreview<Model: PersistentModel, Content: View>: View {
    var content: (Model) -> Content
    
    init(@ViewBuilder content: @escaping (Model) -> Content) {
        self.content = content
    }
    
    var body: some View {
        PreviewContentView(content: content)
            .modelContainer(DataContainer().getContainer())
    }
    
    
    
    struct PreviewContentView: View {
        @Query private var models: [Model]
        var content: (Model) -> (Content)
        
        var body: some View {
            if let model = models.first {
                NavigationStack {
                    content(model)
                }
            } else {
                ContentUnavailableView("Could not load any model for preview", image: "xmark")
            }
        }
    }
    
}
