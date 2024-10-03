//
//  UIApplication.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 29.09.24.
//

import UIKit

extension UIApplication {
    static func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsURL)
        else { return }
        UIApplication.shared.open(settingsURL)
    }
    
}
