//
//  AppRouter.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.07.24.
//

import SwiftUI

final class AppRouter: Router {
    @Published var path: [Route]
    
    init(initialPath: [Route]? = nil) { self.path = initialPath ?? [Route]() }
    
    func navigate(to route: Route) { path.append(route) }
    
    func navigateBack() { path.removeLast() }
    func removeAllWithCurrentModel() { path.removeAll { $0 == path.last } }
    func resetToRoot() { path.removeLast(path.count) }
}
