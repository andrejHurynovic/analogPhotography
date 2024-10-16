//
//  RoundedBoundingBox.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 16.10.2024.
//

import SwiftUI

struct RoundedBoundingBox: Shape {
    var cornerRadius: CGFloat = 10
    var lineLength: CGFloat = 20
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Top-left corner
        path.move(to: CGPoint(x: rect.minX + lineLength, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 180),
                    clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + lineLength))
        
        // Bottom-left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY - lineLength))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 90),
                    clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX + lineLength, y: rect.maxY))
        
        // Bottom-right corner
        path.move(to: CGPoint(x: rect.maxX - lineLength, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 0),
                    clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - lineLength))
        
        // Top-right corner
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY + lineLength))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: -90),
                    clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX - lineLength, y: rect.minY))
        
        return path
    }
}
