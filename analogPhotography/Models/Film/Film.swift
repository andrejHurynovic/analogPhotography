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
    var iso: Int?
    var exposureTolerance: FilmExposureTolerance? 
    
    var dxCode: DXCode { DXCode(from: self) }
    
    @Relationship var format: FilmFormat?
    @Relationship var process: FilmProcess?
    @Relationship var rolls: [FilmRoll]
    
    init(name: String = "", capacity: Int? = nil, iso: Int? = nil, exposureTolerance: FilmExposureTolerance? = nil, format: FilmFormat? = nil, process: FilmProcess? = nil, rolls: [FilmRoll] = []) {
        self.name = name
        self.capacity = capacity
        self.exposureTolerance = exposureTolerance
        self.iso = iso
        self.format = format
        self.process = process
        self.rolls = rolls
    }
    
}
