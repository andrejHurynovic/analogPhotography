//
//  Array+Compress.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

extension Array where Element: Equatable {
    func compress() -> [(Element, Int)] {
        guard !self.isEmpty else { return [] }
        
        var result: [(Element, Int)] = []
        
        var currentValue = self[0]
        var count = 1
        
        for i in 1..<self.count {
            if self[i] == currentValue {
                count += 1
            } else {
                result.append((currentValue, count))
                currentValue = self[i]
                count = 1
            }
        }
        
        result.append((currentValue, count))
        return result
    }
}
