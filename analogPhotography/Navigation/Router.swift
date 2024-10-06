//
//  Router.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.07.24.
//

import SwiftUI

protocol Router: ObservableObject {
    var path: [Route] { get }
    
    init(initialPath: [Route]?)
    
    func navigate(to route: Route)
    func navigateBack()
    
    func removeAllWithCurrentModel()
    func resetToRoot()
}
