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
    
    var mapPinSize: CGFloat = 32
    
    var body: some View {
        if showPicker {
            Circle()
                .frame(width: 4, height: 4)
                .overlay {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: mapPinSize, height: mapPinSize)
                    //Offset from dot.
                        .offset(y: -mapPinSize)
                        .padding()
                    //Dynamic offset for transition animation.
                        .offset(y: inTransition ? -64.0 : 0.0)
                }
        }
    }
}
