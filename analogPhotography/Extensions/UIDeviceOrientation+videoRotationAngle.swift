//
//  UIDeviceOrientation+videoRotationAngle.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 30.09.24.
//

import UIKit

extension UIDeviceOrientation {
    func videoRotationAngle() -> CGFloat? {
        return switch self {
        case .portrait: 90
        case .portraitUpsideDown: 270
        case .landscapeLeft: 0
        case .landscapeRight: 180
        default: nil
        }
    }
}
