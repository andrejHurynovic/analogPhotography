//
//  MapPickerViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.07.24.
//

import Foundation
import SwiftUI
import MapKit

@Observable class MapPickerViewModel {
    //Map
    var position: MapCameraPosition = .automatic
    var selectedLocation: Binding<Location?>
    private var previousDistance: Double?
    
    var selectedItem: LocationItem?
    
    //Picker
    var inTransition: Bool = false
    var inTransitionToItem: Bool = false
    var showPicker: Bool = true
    
    //DescriptionText
    var isUpdatingDescriptionText: Bool = true
    var descriptionText: String = "placeholder street"
    private var geocoderTask: Task<(), Never>? = nil
    
    //Search
    var searchText: String = ""
    
    init(selectedLocation: Binding<Location?>) {
        self._selectedLocation = selectedLocation
    }
    
    //MARK: MapCamera and picker transitions
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
    func mapCameraEnded(coordinate: CLLocationCoordinate2D, distance: Double) {
        withAnimation {
            //This method should be above inTransition method for stable redacted in MapPickerMenuView
            updatePlaceDescription()
            
            inTransition = false
            inTransitionToItem = false
            
            previousDistance = distance
            selectedLocation.wrappedValue = Location(from: coordinate)
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
                                         distance: previousDistance ?? Constants.Other.defaultMapDistance))
            showPicker = false
        }
    }
    
    //MARK: DescriptionText
    private func updatePlaceDescription() {
        isUpdatingDescriptionText = true
        geocoderTask?.cancel()
        
        guard let location = selectedLocation.wrappedValue else { return }
        
        geocoderTask = Task {
            let coordinate = CLLocation(latitude: location.latitude,
                                        longitude: location.longitude)
            let geocoder = CLGeocoder()
            
            guard let results = try? await geocoder.reverseGeocodeLocation(coordinate),
                  let result = results.first else { return }
            
            let resultsHierarchy = [result.thoroughfare,
                              result.subLocality,
                              result.locality,
                              result.subAdministrativeArea,
                              result.administrativeArea,
                              result.country]
            guard let descriptionText = (resultsHierarchy.compactMap { $0 }).first else { return }
            
            self.descriptionText = descriptionText
            self.isUpdatingDescriptionText = false
        }
    }
    
    //MARK: Search
}
