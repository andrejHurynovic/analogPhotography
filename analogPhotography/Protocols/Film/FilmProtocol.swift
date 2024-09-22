//
//  FilmProtocol.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 21.09.24.
//

import SwiftData

protocol FilmProtocol {
    var name: String? { get set }
    
    var capacity: Int? { get set }
    var iso: Int? { get set }
    var exposureTolerance: FilmExposureTolerance? { get set }
    
    @Relationship var format: FilmFormat? { get set }
    @Relationship var process: FilmProcess? { get set }
    @Relationship var rolls: [FilmRoll] { get set }
}
