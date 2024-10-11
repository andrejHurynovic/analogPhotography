//
//  String.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 13.06.24.
//

extension String {
    func removingFirst(_ k: Int) -> String {
        String(self.dropFirst(k))
    }
}
