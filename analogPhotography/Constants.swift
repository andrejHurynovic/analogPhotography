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
    
    struct DXCode {
        static let speeds: [Int?] = [nil, nil, nil, nil, nil, nil, nil, nil, 25, 50, 100, 200, 400, 800, 1600, 3200, 32, 64, 125, 250, 500, 1000, 2000, 4000, 40, 80, 160, 320, 640, 1250, 2500, 5000]
        static let capacities = [nil, 12, 20, 24, 36, 48, 60, 72]
        static let exposureTolerances: [FilmExposureTolerance] = [.init(-0.5, 0.5), .init(-1, 1), .init(-1, 2), .init(-1, 3)]
    }
    
    struct Map {
        static let defaultMapDistance: Double = 200_000
    }
}
