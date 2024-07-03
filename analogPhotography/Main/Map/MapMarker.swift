//
//  MapMarker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 3.07.24.
//

import SwiftUI

struct MapMarker: View {
    var showPicker: Bool
    var inTransition: Bool
    
    var body: some View {
        if showPicker {
            VStack {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .offset(y: inTransition ? -64.0 : 0.0)
                
                Circle()
                    .frame(width: 4, height: 4)
            }
            .alignmentGuide(VerticalAlignment.center, computeValue: { dimension in
                dimension[VerticalAlignment.bottom]
            })
        }
    }
}
