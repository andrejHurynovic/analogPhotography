//
//  DXCodeDecoder.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 3.10.24.
//

import UIKit

extension DXCode {
    init?(from image: CGImage, _ barcodeSide: CGRect.RelativePosition?) async {
        let (rotation, correctedBarcodeSide) = DXCode.findRotationDirection(image.width, image.height, barcodeSide)
        guard let croppedImage = await DXCode.crop(image),
              var brightnessData = await DXCode.brightnessPixelData(croppedImage) else { return nil }
        
        var rows = croppedImage.height
        var columns = croppedImage.width
        
        if let rotation = rotation {
            (brightnessData, rows, columns) = DXCode.rotateBrightnessData(brightnessData, rows, columns, rotation)
        }
        
        let compressedRows = await DXCode.compressRows(brightnessData, columns, rows)
        guard let firstRowThreshold = await DXCode.calculateRowBitThreshold(from: compressedRows.0),
              let secondRowThreshold = await DXCode.calculateRowBitThreshold(from: compressedRows.1) else { return nil }
        
        guard let firstRow = await DXCode.dxCodeBitsRows(from: compressedRows.0.filter { $1 > firstRowThreshold }),
              let secondRow = await DXCode.dxCodeBitsRows(from: compressedRows.1.filter { $1 > secondRowThreshold }) else { return nil }
        
        guard let (firstRow, secondRow) = DXCode.rotateDXCodeRows(firstRow, secondRow, correctedBarcodeSide) else { return nil }
        
        self.speedBits = firstRow.suffix(5)
        self.capacityBits = secondRow.prefix(4).suffix(3)
        self.exposureToleranceBits = secondRow.suffix(2)
    }
    
    //MARK: Image modification.
    
    fileprivate enum ImageRotationDirection {
        case clockwise
        case counterclockwise
    }
    
    fileprivate static func findRotationDirection(_ columns: Int, _ rows: Int, _ barcodeSide: CGRect.RelativePosition?) -> (ImageRotationDirection?, CGRect.RelativePosition?) {
        guard columns < rows else { return (nil, barcodeSide) }
        switch barcodeSide {
        case .left:
            return (.clockwise, .above)
        case .right:
            return (.counterclockwise, .above)
        default:
            return (.counterclockwise, nil)
        }
    }
    
    fileprivate static func crop(_ image: CGImage, correctionModifier: Double = 0.05) async -> CGImage? {
        let widthCorrection = Double(image.width) * correctionModifier
        let heightCorrection = Double(image.height) * correctionModifier
        let width = image.width - Int(widthCorrection * 2)
        let height = image.height - Int(heightCorrection * 2)
        
        let croppedCGRect = CGRect(x: Int(widthCorrection), y: Int(heightCorrection), width: width, height: height)
        
        return image.cropping(to: croppedCGRect)
    }
    
    fileprivate static func brightnessPixelData(_ image: CGImage) async -> [UInt8]? {
        var pixelData = [UInt8](repeating: 0, count: image.width * image.height)
        
        guard let context = CGContext(data: &pixelData,
                                      width: image.width,
                                      height: image.height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: image.width,
                                      space: CGColorSpaceCreateDeviceGray(),
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue)
        else { return nil }
        context.draw(image, in: CGRect(x: 0, y: 0, width: CGFloat(image.width), height: CGFloat(image.height)))
        
        return pixelData
    }
    
    fileprivate static func rotateBrightnessData(_ brightnessData: [UInt8], _ rows: Int, _ columns: Int, _ rotationDirection: ImageRotationDirection) -> (brightnessData: [UInt8], rows: Int, columns: Int) {
        var rotatedMatrix = [UInt8](repeating: brightnessData[0], count: rows * columns)
        
        switch rotationDirection {
        case .clockwise:
            for r in 0..<rows {
                for c in 0..<columns {
                    rotatedMatrix[c * rows + (rows - 1 - r)] = brightnessData[r * columns + c]
                }
            }
        case .counterclockwise:
            for r in 0..<rows {
                for c in 0..<columns {
                    rotatedMatrix[(columns - 1 - c) * rows + r] = brightnessData[r * columns + c]
                }
            }
        }
        
        return (rotatedMatrix, columns, rows)
    }
    
    //MARK: Data transformation.
    fileprivate static func calculateRowBitThreshold(from compressedRow: [(DXCodeBit, Int)]) async -> Int? {
        guard let max = compressedRow.map({ $1 }).max() else { return nil }
        return max / 6
    }
    
    fileprivate static func compressRows(_ brightnessData: [UInt8], _ columns: Int, _ rows: Int) async -> ([(DXCodeBit, Int)], [(DXCodeBit, Int)]) {
        let imageMedian = rows / 2
        let rowMedianRangeModifier = rows / 15
        let firstDXCodeRowCenter = imageMedian / 2
        let secondDXCodeRowCenter = Int(Float(imageMedian) * 1.5)
        
        let firstRowRange = (firstDXCodeRowCenter - rowMedianRangeModifier)...(firstDXCodeRowCenter + rowMedianRangeModifier)
        let secondRowRange = (secondDXCodeRowCenter - rowMedianRangeModifier)...(secondDXCodeRowCenter + rowMedianRangeModifier)
        
        async let compressedFirstRow = await compressedBitsArray(brightnessData,
                                                                 columns: columns,
                                                                 rowsRange: firstRowRange)
        async let compressedSecondRow = await compressedBitsArray(brightnessData,
                                                                  columns: columns,
                                                                  rowsRange: secondRowRange)
        return await (compressedFirstRow, compressedSecondRow)
        
        @Sendable func compressedBitsArray(_ brightnessPixelData: [UInt8], columns: Int, rowsRange: ClosedRange<Int> ) async -> [(DXCodeBit, Int)] {
            let columnAverages = await withTaskGroup(of: Int.self) { taskGroup in
                for width in 0..<columns {
                    taskGroup.addTask {
                        let fullColumn = rowsRange.map { height in
                            brightnessPixelData[height * columns + width]
                        }
                        return fullColumn.reduce(into: 0, { $0 += Int($1) }) / fullColumn.count
                    }
                }
                return await taskGroup.reduce(into: [Int](), { $0.append($1) })
            }
            
            let maximalDifferenceNumbers = columnAverages.findMaxDifference(step: 1)!
            let threshold = (maximalDifferenceNumbers.first + maximalDifferenceNumbers.second) / 2
            var compressedBits = columnAverages.map( { (($0 > threshold ? DXCodeBit.metal : DXCodeBit.paint)) } ).compress()
            compressedBits.removeAll { compressedBit in
                compressedBit.1 < columns / 8
            }
            
            return compressedBits
        }
    }
    
    //MARK: Transformation.
    
    fileprivate static func dxCodeBitsRows(from compressedBits: [(DXCodeBit, Int)], baseBitSizeModifier: Float = 0.9) async -> [DXCodeBit]? {
        let bitWidth = compressedBits.map ({ $1 }).reduce(0, +) / 6
        
        var bitSizeModifier = baseBitSizeModifier
        var dxCodeBits: [DXCodeBit]?
        
        repeat {
            let reducedBits: [DXCodeBit] = compressedBits
                .map ({ Array(repeating: $0, count: $1 / Int((Float(bitWidth) * bitSizeModifier)))   })
                .reduce(into: [], +=)
            
            if reducedBits.count == 6 {
                dxCodeBits = reducedBits
            }
            
            bitSizeModifier -= 0.05
            
        } while (dxCodeBits == nil && bitSizeModifier > 0.5 )
        return dxCodeBits
    }
    
    //MARK: - DXCode rotation.
    
    fileprivate static func rotateDXCodeRows(_ firstRow: [DXCodeBit], _ secondRow: [DXCodeBit], _ barcodeSide: CGRect.RelativePosition?) -> (firstRow: [DXCodeBit], secondRow: [DXCodeBit])? {
        var firstColumnIsMetal: Bool { [firstRow.first!, secondRow.first!] == [.metal, .metal] }
        var secondColumnIsMetal: Bool { [firstRow.last!, secondRow.last!] == [.metal, .metal] }
        
        var resultFirstRow: [DXCodeBit]?
        var resultSecondRow: [DXCodeBit]?
        
        guard firstColumnIsMetal && secondColumnIsMetal != false else { return nil }
        
        if secondColumnIsMetal {
            if firstColumnIsMetal {
                guard let barcodeSide = barcodeSide,
                      [CGRect.RelativePosition.below, CGRect.RelativePosition.above].contains(barcodeSide) else { return nil }
                if barcodeSide == .below {
                    let tempFirstRow = firstRow
                    resultFirstRow = secondRow.reversed()
                    resultSecondRow = tempFirstRow.reversed()
                }
            } else {
                let tempFirstRow = firstRow
                resultFirstRow = secondRow.reversed()
                resultSecondRow = tempFirstRow.reversed()
            }
        }
        
        return (resultFirstRow ?? firstRow, resultSecondRow ?? secondRow)
    }
    
}

