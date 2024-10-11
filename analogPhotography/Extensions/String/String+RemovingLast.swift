//
//  String+RemovingLast.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.10.2024.
//


extension String {
    func removingLast(_ k: Int) -> String {
        String(self.dropLast(k))
    }
}