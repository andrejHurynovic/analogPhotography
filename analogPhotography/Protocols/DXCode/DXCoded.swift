//
//  DXCoded.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 21.09.24.
//

import SwiftData

protocol DXCoded {
    var speedBits: [DXCodeBit] { get set }
    var capacityBits: [DXCodeBit] { get set }
    var exposureToleranceBits: [DXCodeBit] { get set }
    var dxCodeBits: DXCodeBits { get set }
}
