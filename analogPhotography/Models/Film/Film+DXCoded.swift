//
//  Film+DXCoded.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 21.09.24.
//

import Foundation

extension Film: DXCoded {
    var speedBits: [DXCodeBit] {
        get { getBits(item: self.iso, items: Constants.DXCode.speeds, numberOfBits: 5) }
        set { self.iso = setBits(newValue: newValue, items: Constants.DXCode.speeds) }
    }
    
    var capacityBits: [DXCodeBit] {
        get { getBits(item: self.capacity, items: Constants.DXCode.capacities, numberOfBits: 3) }
        set { self.capacity = setBits(newValue: newValue, items: Constants.DXCode.capacities)}
    }
    
    var exposureToleranceBits: [DXCodeBit] {
        get { getBits(item: self.exposureTolerance, items: Constants.DXCode.exposureTolerances, numberOfBits: 2) }
        set { self.exposureTolerance = setBits(newValue: newValue, items: Constants.DXCode.exposureTolerances)}
    }
    
    //MARK: Helpers
    fileprivate func getBits<T: Equatable>(item: T?, items: [T?], numberOfBits: Int) -> [DXCodeBit] {
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
