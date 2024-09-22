//
//  FilmExposureTolerance.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 19.09.24.
//

import Foundation

struct FilmExposureTolerance: Equatable, Codable {
    var upperBound: Decimal
    var lowerBound: Decimal
    
    init(_ lowerBound: Decimal, _ upperBound: Decimal) {
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
}
