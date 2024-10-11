//
//  Array+MostFrequentElement.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

extension Array where Element: Hashable {
    func mostFrequentElement() -> (element: Element, percentage: Double)? {
        guard !self.isEmpty else {
            return nil
        }
        
        var counts: [Element: Int] = [:]
        
        for element in self {
            counts[element, default: 0] += 1
        }
        
        if let (mostFrequent, count) = counts.max(by: { $0.value < $1.value }) {
            let percentage = (Double(count) / Double(self.count)) * 100
            return (mostFrequent, percentage)
        }
        
        return nil
    }
}
