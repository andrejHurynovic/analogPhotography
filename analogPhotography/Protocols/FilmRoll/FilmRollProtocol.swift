//
//  FilmRollProtocol.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 25.10.2024.
//

import Foundation
import SwiftData

protocol FilmRollProtocol: ModelProtocol, Described {
    var name: String? { get set }
    var note: String { get set }
    
    var expired: Bool { get set }
    var creationDate: Date { get set }
    var finished: Bool  { get set }
    
    var film: Film? { get set }
    var photos: [Photo] { get set }
    
    var camera: Camera? { get set }
}
