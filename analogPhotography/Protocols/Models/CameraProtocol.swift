//
//  CameraProtocol.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.10.2024.
//

protocol CameraProtocol: ModelProtocol {
    associatedtype FilmRollType: FilmRollProtocol
    
    var name: String { get set }
    var note: String { get set }
    
    var filmRolls: [FilmRollType] { get set }
}
