//
//  LocationItem.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.06.24.
//

import MapKit

struct LocationItem: Codable, Equatable, Identifiable, Hashable {
    var id: UUID = UUID()
    
    var description: String
        
    var location: Location
    var clLocation: CLLocationCoordinate2D { .init(latitude: location.latitude, longitude: location.longitude) }
}
