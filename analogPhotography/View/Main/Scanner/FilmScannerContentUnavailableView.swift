//
//  FilmScannerContentUnavailableView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 29.09.24.
//

import SwiftUI

struct FilmScannerContentUnavailableView: View {
    var description: String
    var actionTitle: String?
    var action: (() async -> ())?
    
    var body: some View {
        ContentUnavailableView(label: {
            Label("Camera access", systemImage: "camera.fill")
        }, description: {
            Text(description)
        }, actions: {
            if let action = action, let actionTitle = actionTitle {
                Button(action: {
                    Task { await action() }
                }) {
                    Text(actionTitle)
                }
            }
        })
    }
}
