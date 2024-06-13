//
//  String.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 13.06.24.
//

import Foundation

extension String {
    func removingFirst(_ k: Int) -> String {
        String(self.dropFirst(k))
    }
    func removingLast(_ k: Int) -> String {
        String(self.dropLast(k))
    }
}

extension String {
    func trimmingPrefix(_ prefix: String) -> String {
        var temp = self
        temp.trimPrefix(prefix)
        return temp
    }
}
