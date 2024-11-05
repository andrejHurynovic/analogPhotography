//
//  Color+Random.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 30.10.2024.
//

import SwiftUICore

extension Color {
    static public func random() -> Color {
        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}
