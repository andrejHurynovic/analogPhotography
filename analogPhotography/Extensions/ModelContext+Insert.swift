//
//  ModelContextExtensions.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

import SwiftData

extension ModelContext {
    public func insert(_ models: Array<any PersistentModel>) throws {
        try self.transaction {
            models.forEach { model in
                self.insert(model)
            }
        }
    }
}
