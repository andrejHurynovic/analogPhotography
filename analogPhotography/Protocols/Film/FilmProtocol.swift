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
    var speed: Int? { get set }
    var exposureTolerance: FilmExposureTolerance? { get set }
    
    var format: FilmFormat? { get set }
    var process: FilmProcess? { get set }
    var rolls: [FilmRoll] { get set }
}
