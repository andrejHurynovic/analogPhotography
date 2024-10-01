//
//  DXCode.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 21.09.24.
//

import CoreImage

struct DXCode {
    private var speedBits: [DXCodeBit]
    private var capacityBits: [DXCodeBit]
    private var exposureToleranceBits: [DXCodeBit]
    
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

//extension Film: DXCoded {
//    
//    var speedBits: [DXCodeBit] {
//        get { getBits(item: self.speed, items: Constants.DXCode.speeds, numberOfBits: 5) }
//        set { self.speed = setBits(newValue: newValue, items: Constants.DXCode.speeds) }
//    }
//    var capacityBits: [DXCodeBit] {
//        get { getBits(item: self.capacity, items: Constants.DXCode.capacities, numberOfBits: 3) }
//        set { self.capacity = setBits(newValue: newValue, items: Constants.DXCode.capacities)}
//    }
//    var exposureToleranceBits: [DXCodeBit] {
//        get { getBits(item: self.exposureTolerance, items: Constants.DXCode.exposureTolerances, numberOfBits: 2) }
//        set { self.exposureTolerance = setBits(newValue: newValue, items: Constants.DXCode.exposureTolerances)}
//    }
//    
//    var dxCodeBits: DXCodeBits {
//        get { return .init(firstRow: speedBits, secondRow: capacityBits + exposureToleranceBits) }
//        set {
//            speedBits = newValue.firstRow
//            capacityBits = Array(newValue.secondRow.prefix(3))
//            exposureToleranceBits = Array(newValue.secondRow.suffix(2))
//        }
//    }
//    
//    //MARK: Helpers
//    fileprivate func getBits<T: Equatable>(item: T?, items: [T?], numberOfBits: Int) -> [DXCodeBit] {
//        guard let item = item,
//              let index = items.firstIndex(of: item),
//              items[index] != nil else {
//            return Array(repeatElement(.unknown, count: numberOfBits))
//        }
//        return (0...(numberOfBits - 1)).map {
//            return DXCodeBit(rawValue: (index >> $0 & 0b1)) ?? .unknown
//        }
//    }
//    fileprivate func setBits<T: Equatable>(newValue: [DXCodeBit], items: [T?]) -> T? {
//        guard newValue.contains(.unknown) == false else { return nil }
//        let index = newValue.indices.map {
//            newValue[$0].rawValue << $0 }.reduce(0, {
//                return $0 + $1
//            }
//            )
//        return items[index]
//    }
//
//}
