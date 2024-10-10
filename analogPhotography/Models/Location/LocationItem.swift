//
//  LocationItem.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.06.24.
//

import MapKit

struct LocationItem: Codable, Equatable, Identifiable, Hashable {
    var id: UUID = UUID()
    
    var description: String?
        
    var location: Location
    var clLocation: CLLocationCoordinate2D { .init(latitude: location.latitude, longitude: location.longitude) }
    
    init(description: String? = nil, location: Location) {
        self.description = description
        self.location = location
    }
    
    init(from item: MKMapItem) {
        self.location = Location(from: item.placemark.coordinate)
    }
}
