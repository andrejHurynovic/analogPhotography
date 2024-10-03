//
//  DXCode.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 21.09.24.
//

import CoreImage
import UIKit

struct DXCode: Hashable {
    var speedBits: [DXCodeBit]
    var capacityBits: [DXCodeBit]
    var exposureToleranceBits: [DXCodeBit]
    
    init(speed: Int?, capacity: Int?, exposureTolerance: FilmExposureTolerance?) {
        speedBits = DXCode.getBits(item: speed, items: Constants.DXCode.speeds, numberOfBits: 5)
        capacityBits = DXCode.getBits(item: capacity, items: Constants.DXCode.capacities, numberOfBits: 3)
        exposureToleranceBits = DXCode.getBits(item: exposureTolerance, items: Constants.DXCode.exposureTolerances, numberOfBits: 2)
    }
    
    var firstRow: [DXCodeBit] { speedBits }
    var secondRow: [DXCodeBit] { capacityBits + exposureToleranceBits }
    
    //MARK: Helpers
    fileprivate static func getBits<T: Equatable>(item: T?, items: [T?], numberOfBits: Int) -> [DXCodeBit] {
        guard let item = item,
              let index = items.firstIndex(of: item),
              items[index] != nil else {
            return Array(repeatElement(.unknown, count: numberOfBits))
        }
        return (0...(numberOfBits - 1)).map {
            return DXCodeBit(rawValue: (index >> $0 & 0b1)) ?? .unknown
        }
    }
}


