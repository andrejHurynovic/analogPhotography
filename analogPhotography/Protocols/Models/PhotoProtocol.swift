//
//  PhotoProtocol.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.10.2024.
//

import Foundation

protocol PhotoProtocol: ModelProtocol, Comparable {
    associatedtype FilmRollType: FilmRollProtocol
    
    var order: Int { get set }
    var date: Date? { get set }
    
    var location: Location? { get set }
    var locationDescription: String? { get set }
    
    var aperture: String? { get set }
    var shutterSpeed: String { get set }
    
    var ruined: Bool { get set }
    var note: String { get set }
    
    var image: Data? { get set }
    
    var filmRoll: FilmRollType? { get set }
}
