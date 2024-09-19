//
//  DXCode.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 18.09.24.
//

import Foundation

struct DXCode {
    //MARK: Speed
    private let speeds: [Int?] = [nil, 32, 25, 40, nil, 500, 400, 640, nil, 125, 100, 160, nil, 2000, 1600, 2500, nil, 64, 50, 80, nil, 1000, 800, 1250, nil, 250, 200, 320]
    
    private var speedData: Int?
    var speed: Int? {
        get { getValue(data: speedData, in: speeds) }
        set { speedData = setValue(newValue: newValue, from: speeds) }
    }
    
    //MARK: Capacity
    private let capacities = [nil, 36, 20, 60, 12, 48, 24, 72]
    
    private var capacityData: Int?
    var capacity: Int? {
        get { getValue(data: capacityData, in: capacities) }
        set { capacityData = setValue(newValue: newValue, from: capacities) }
    }
    
    //MARK: Exposure tolerance
    private let exposureTolerances: [FilmExposureTolerance] = [-0.5...0.5, -1...1, -1...2, -1...3]
    
    private var exposureToleranceData: Int?
    var exposureTolerance: FilmExposureTolerance? {
        get { getValue(data: exposureToleranceData, in: exposureTolerances) }
        set { exposureToleranceData = setValue(newValue: newValue, from: exposureTolerances) }
    }
    

    
    //MARK: Initialisations
    
    init(from film: Film) {
        self.speed = film.iso
        self.capacity = film.capacity
        self.exposureTolerance = film.exposureTolerance
    }
    
    init(from code: Int) throws {
        self.speedData = getBits(0...4, from: code)
        self.capacityData = getBits(5...7, from: code)
        self.exposureToleranceData = getBits(8...9, from: code)
    }
    
    
    //MARK: Helpers
    
    private func getValue<T>(data: Int? , in items: [Optional<T>]) -> Optional<T> {
        guard let data = data,
              items.indices.contains(data) else { return nil }
        return items[data]
    }
    private func setValue<T: Equatable>(newValue: T?, from items: [T?]) -> Int? {
        guard let newValue = newValue,
              let index = items.firstIndex(of: newValue) else { return nil }
        return index
    }
    
    private func getBits(_ range: ClosedRange<UInt8>, from data: Int) -> Int {
        let length = abs(Int(range.upperBound - range.lowerBound)) + 1
        let mask = (1 << length) - 1 // 0b11111 - 0b1 = 0b01111
        
        return data >> range.lowerBound & mask
    }
}


