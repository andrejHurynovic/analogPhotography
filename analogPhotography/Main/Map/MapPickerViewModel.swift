//
//  MapPickerViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.07.24.
//

import Foundation
import SwiftUI
import MapKit

extension MapPicker {
    @Observable class MapPickerViewModel {
        var position: MapCameraPosition = .automatic
        var finalLocation: CLLocationCoordinate2D?
        var finalDistance: Double?
        
        var selectedItem: LocationItem?
        
        var inTransition: Bool = false
        var inTransitionToItem: Bool = false
        var showPicker: Bool = true
        
        func mapCameraUpdated() {
            withAnimation {
                guard inTransition == false else {return}
                inTransition = true
                guard inTransitionToItem == false else { return }
                guard selectedItem == nil else {
                    selectedItem = nil
                    return
                }
            }
        }
        func mapCameraEnded(position: CLLocationCoordinate2D, distance: Double) {
            withAnimation {
                inTransition = false
                inTransitionToItem = false
                
                finalLocation = position
                finalDistance = distance
            }
        }
        
        func selectedItemUpdated(item: LocationItem?) {
            withAnimation {
                guard let item = item else {
                    showPicker = true
                    return
                }
                inTransitionToItem = true
                position = .camera(MapCamera(centerCoordinate: item.clLocation,
                                             distance: finalDistance ?? Constants.Other.defaultMapDistance))
                showPicker = false
            }
        }
    }
}
