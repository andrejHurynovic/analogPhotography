//
//  ModelContextExtensions.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftData

extension ModelContext {
    public func insert<T>(_ models: Array<T>) where T : PersistentModel {
        models.forEach { model in
            self.insert(model)
        }
    }
    
}
