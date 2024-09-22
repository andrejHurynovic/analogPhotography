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
        static let sampleISOs: [Int] = [50, 100, 200, 400, 800, 1200]
    }
    
    struct DXCode {
        static let speeds: [Int?] = [nil, 32, 25, 40, nil, 500, 400, 640, nil, 125, 100, 160, nil, 2000, 1600, 2500, nil, 64, 50, 80, nil, 1000, 800, 1250, nil, 250, 200, 320, nil, 4000, 3200, 5000]
        static let capacities = [nil, 36, 20, 60, 12, 48, 24, 72]
        static let exposureTolerances: [FilmExposureTolerance] = [.init(-0.5, 0.5), .init(-1, 1), .init(-1, 2), .init(-1, 3)]
    }
    
    struct Map {
        static let defaultMapDistance: Double = 200_000
    }
}
