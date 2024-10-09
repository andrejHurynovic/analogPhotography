//
//  Bool.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 4.06.24.
//

extension Bool: @retroactive Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        //true > false
        !lhs && rhs
    }
}
