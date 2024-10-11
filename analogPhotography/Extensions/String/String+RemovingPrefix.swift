//
//  String+RemovingPrefix.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 11.10.2024.
//


extension String {
    func trimmingPrefix(_ prefix: String) -> String {
        var temp = self
        temp.trimPrefix(prefix)
        return temp
    }
}