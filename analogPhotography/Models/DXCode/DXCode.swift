//
//  DXCode.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 21.09.24.
//

import CoreImage
import UIKit

struct DXCode: Hashable {
    static let speeds: [Int?] = [nil, nil, nil, nil, nil, nil, nil, nil, 25, 50, 100, 200, 400, 800, 1600, 3200, 32, 64, 125, 250, 500, 1000, 2000, 4000, 40, 80, 160, 320, 640, 1250, 2500, 5000]
    static let capacities = [nil, 12, 20, 24, 36, 48, 60, 72]
    static let exposureTolerances: [FilmExposureTolerance] = [.init(-0.5, 0.5), .init(-1, 1), .init(-1, 2), .init(-1, 3)]
    
    //  Stored properties.
    var speedBits: [DXCodeBit]
    var capacityBits: [DXCodeBit]
    var exposureToleranceBits: [DXCodeBit]
    //  Calculated properties.
    var speed: Int? { setBits(newValue: speedBits, items: DXCode.speeds) }
    var capacity: Int? { setBits(newValue: capacityBits, items: DXCode.capacities) }
    var exposureTolerance: FilmExposureTolerance? { setBits(newValue: exposureToleranceBits, items: DXCode.exposureTolerances) }
    
    init(speed: Int?, capacity: Int?, exposureTolerance: FilmExposureTolerance?) {
        speedBits = DXCode.getBits(item: speed, items: DXCode.speeds, numberOfBits: 5)
        capacityBits = DXCode.getBits(item: capacity, items: DXCode.capacities, numberOfBits: 3)
        exposureToleranceBits = DXCode.getBits(item: exposureTolerance, items: DXCode.exposureTolerances, numberOfBits: 2)
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
    fileprivate func setBits<T: Equatable>(newValue: [DXCodeBit], items: [T?]) -> T? {
        guard newValue.contains(.unknown) == false else { return nil }
        let index = newValue.indices.map {
            newValue[$0].rawValue << $0 }.reduce(0, {
                return $0 + $1
            }
            )
        return items[index]
    }
    
}


