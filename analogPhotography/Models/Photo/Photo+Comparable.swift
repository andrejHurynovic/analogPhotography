//
//  Photo+Comparable.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 05.11.2024.
//

extension Photo {
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.order < rhs.order
    }
}
