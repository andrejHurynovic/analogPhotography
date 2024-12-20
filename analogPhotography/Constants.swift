//
//  Constants.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 16.06.24.
//

import Foundation

struct Constants {
    struct Photo {
        static let sampleAperture: [String] = [2.8, 4, 5.6, 8, 11, 16, 22].map { String($0) }
        static let shutterSpeeds: [String] = ["1"] +  [2, 4, 8, 15, 30, 60, 125, 250, 500, 1000].map({ "1/\($0)" })
    }
    
    struct Film {
        static let sampleSpeeds: [Int] = [50, 100, 200, 400, 800, 1200]
    }
    
    struct FilmRoll {
        static let numberOfPhotosLeftToShowFinishButton: Int = 2
    }
    
    struct Map {
        static let defaultMapDistance: Double = 200_000
    }
    
    struct Scanner {
        static let requestDelay: Duration = .milliseconds(100)
        static let dxCodeBufferSize: Int = 15
        static let dxCodeDetectorPrecision = 0.7
    }
}
