//
//  DXCodeBit.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.09.24.
//

enum DXCodeBit: Int, Equatable {
    case paint = 0
    case metal = 1
    case unknown = 2
    case metalConstant = 3
    
    mutating func toggle() {
        switch self {
        case .paint:
            self = .metal
        case .metal:
            self = .paint
        case .unknown:
            self = .metal
        case .metalConstant:
            break
        }
    }
}
