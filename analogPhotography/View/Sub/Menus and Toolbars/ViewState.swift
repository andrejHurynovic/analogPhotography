//
//  ViewState.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 15.07.24.
//

enum ViewState {
    case showing
    case editing
    case creating
    case creatingAndSelecting
    
    var editingAvailable: Bool {
        switch self {
        case .showing: return false
        case .editing, .creating, .creatingAndSelecting: return true
        }
    }
}
