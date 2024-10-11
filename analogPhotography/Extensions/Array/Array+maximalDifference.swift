//
//  Array+MaximalDifference.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.10.24.
//

extension Array where Element: SignedNumeric, Element: Comparable {
    func findMaxDifference(step: Int) -> (first: Element, second: Element, position: Int)? where Element: Comparable {
        guard self.count >= 2 + step else {
            return nil
        }
        
        var maxDifference: Element?
        var result: (Element, Element, Int)? = nil
        
        for i in 0..<(self.count - step - 1) {
            let firstElement = self[i]
            let secondElement = self[i + step + 1]
            
            let difference = abs(firstElement - secondElement)
            
            if difference > maxDifference ?? 0 {
                maxDifference = difference
                result = (firstElement, secondElement, i + 1)
            }
        }
        
        return result
    }
}
