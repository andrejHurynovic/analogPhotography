//
//  Constants.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 16.06.24.
//

import Foundation

struct Constants {
    struct Other {
        static let shutterSpeeds: [String] = ["1"] +  [2, 4, 8, 15, 30, 60, 125, 250, 500, 1000].map({ "1/" + (String($0)) })
        static let defaultMapDistance: Double = 200_000
    }
}
