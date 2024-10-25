//
//  FilmProtocol.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 21.09.24.
//

import SwiftData

protocol FilmProtocol: ModelProtocol, Described {
    associatedtype FilmRollType: FilmRollProtocol
    
    var name: String? { get set }
    
    var capacity: Int? { get set }
    var speed: Int? { get set }
    var exposureTolerance: FilmExposureTolerance? { get set }
    
    var dxCode: DXCode { get }
    var dxBarcodes: Set<String> { get set }
    
    var format: FilmFormat? { get set }
    var process: FilmProcess? { get set }
    var rolls: [FilmRollType] { get set }
    
    init(from: DXCode)
}
