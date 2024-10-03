//
//  CGRect+RelativePosition.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.10.24.
//

import Foundation

extension CGRect {
    enum RelativePosition {
        case above
        case below
        case left
        case right
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case same
    }

    func relativePosition(to other: CGRect) -> RelativePosition {
        let centerX1 = self.midX
        let centerY1 = self.midY
        let centerX2 = other.midX
        let centerY2 = other.midY
        
        let dx = centerX2 - centerX1
        let dy = centerY2 - centerY1
        
        if dx == 0 && dy == 0 {
            return .same
        } else if abs(dx) > abs(dy) {
            return dx > 0 ? .left : .right
        } else if abs(dx) < abs(dy) {
            return dy > 0 ? .below : .above
        } else {
            if dx > 0 && dy > 0 {
                return .bottomRight
            } else if dx > 0 && dy < 0 {
                return .topRight
            } else if dx < 0 && dy > 0 {
                return .bottomLeft
            } else {
                return .topLeft
            }
        }
    }
}
