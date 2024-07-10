//
//  MapPickerViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.07.24.
//

import SwiftUI
import MapKit

@Observable class MapPickerViewModel {
    //Map
    var position: MapCameraPosition = .automatic
    private var selectedLocation: Binding<Location?>
    private var previousDistance: Double?
    private var rect: MKMapRect?

    var selectedItem: LocationItem?
    
    //Picker
    var inTransition: Bool = false
    private var inTransitionToItem: Bool = false
    var showPicker: Bool = true
    
    //Search
    var searchText: String = ""
    var searchItems: [MKMapItem] = []
    var searchBarState: MapPickerMenuSearchBatState = .description
    
    //DescriptionText
    var isUpdatingDescriptionText: Bool = true
    var descriptionText: String = ""
    private var geocoderTask: Task<(), Never>? = nil
    
    init(selectedLocation: Binding<Location?>) {
        self._selectedLocation = selectedLocation
    }
    
    //MARK: MapCamera and picker transitions
    func mapCameraUpdated() {
        guard inTransition == false else {return}
        withAnimation {
            inTransition = true
            
            guard inTransitionToItem == false else { return }
            
            guard selectedItem == nil else {
                selectedItem = nil
                return
            }
        }
    }
    func mapCameraEnded(context: MapCameraUpdateContext) {
        //This method should be above inTransition change for stable redacted state in MapPickerMenuView
        updatePlaceDescription()
        
        self.rect = context.rect
        self.previousDistance = context.camera.distance
        withAnimation {
            inTransition = false
            inTransitionToItem = false
            
            selectedLocation.wrappedValue = Location(from: context.camera.centerCoordinate)
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
                                         distance: previousDistance ?? Constants.Map.defaultMapDistance))
            showPicker = false
        }
    }
    
    //MARK: Search
    func searchFocusedUpdated(_ searchFocus: Bool) {
        searchFocus ? searchFocused() : searchUnfocused()
    }
    
    private func searchFocused() {
        Log.info("searchFocused")
        //        if searchText == descriptionText {
        searchBarState = .search
        //            searchText = ""
        //        }
    }
    
    private func searchUnfocused() {
        Log.info("searchUnfocused")
        //        if searchText == "" {
        searchBarState = .description
        //            searchText = descriptionText
        //        }
    }
    
    func search() {
        guard let rect = rect else { return }
        Task {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            request.resultTypes = [.address, .pointOfInterest]
            request.region = .init(rect)
            
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            await MainActor.run {
                withAnimation {
                    position = .automatic
                    searchItems = response?.mapItems ?? []
                }
            }
            
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
            //            self.searchText = descriptionText
            self.isUpdatingDescriptionText = false
        }
    }
    
    //MARK: Search
}
