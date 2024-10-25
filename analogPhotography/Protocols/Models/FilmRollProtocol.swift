//
//  FilmRollProtocol.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 25.10.2024.
//

import Foundation
import SwiftData

protocol FilmRollProtocol: ModelProtocol, Described {
    associatedtype CameraType: CameraProtocol
    associatedtype FilmType: FilmProtocol
    associatedtype PhotoType: PhotoProtocol
    
    var name: String? { get set }
    var note: String { get set }
    
    var expired: Bool { get set }
    var creationDate: Date { get set }
    var finished: Bool  { get set }
    
    var film: FilmType? { get set }
    var photos: [PhotoType] { get set }
    
    var camera: CameraType? { get set }
}
