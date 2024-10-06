//
//  Film.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftData

@Model
final class Film: FilmProtocol {
    var name: String?
    
    var capacity: Int?
    var speed: Int?
    var exposureTolerance: FilmExposureTolerance? 
    
    var dxCode: DXCode { DXCode(speed: self.speed, capacity: self.capacity, exposureTolerance: self.exposureTolerance) }
    var dxBarcodes: Set<String>
        
    @Relationship var format: FilmFormat?
    @Relationship var process: FilmProcess?
    @Relationship var rolls: [FilmRoll]
    
    init(name: String = "", capacity: Int? = nil, speed: Int? = nil, exposureTolerance: FilmExposureTolerance? = nil, dxBarcodes: Set<String> = [], format: FilmFormat? = nil, process: FilmProcess? = nil, rolls: [FilmRoll] = []) {
        self.name = name
        self.capacity = capacity
        self.exposureTolerance = exposureTolerance
        self.dxBarcodes = dxBarcodes
        self.speed = speed
        self.format = format
        self.process = process
        self.rolls = rolls
    }
    
}

extension Film: Described {
    var uiDescription: String {
        name ?? "Film"
    }
    
}
