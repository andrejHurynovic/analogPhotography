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
    
    var editingAvailable: Bool {
        let editingCriteria: [Self] = [.creating, .editing]
        return editingCriteria.contains { self == $0 }
    }
}
