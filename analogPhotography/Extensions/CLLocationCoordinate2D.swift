//
//  CLLocationCoordinate2D.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.06.24.
//

import MapKit

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
