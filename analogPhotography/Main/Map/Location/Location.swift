//
//  Location.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 3.07.24.
//

import Foundation
import MapKit

struct Location: Codable, Hashable {
    var latitude: Double
    var longitude: Double
    
    var description: String {
        "latitude: \(latitude), longitude: \(longitude)"
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    init(from location: CLLocationCoordinate2D) {
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
}
