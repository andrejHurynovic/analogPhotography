//
//  DXCodeBuffer.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

import SwiftUI

final class DXCodeBuffer: ObservableObject {
    private var potentialDXCodeBuffer = RingBuffer<DXCode>(size: Constants.Scanner.dxCodeBufferSize)
    @Published var dxCode: DXCode?
    
    public func addDXCodeImage(cgImage: CGImage, barcodeSide: CGRect.RelativePosition?) {
        Task { [weak self] in
            let dxCode = await DXCodeBuffer.decode(cgImage, barcodeSide)
            guard let self = self else { return }
            Task { @MainActor in
                self.add(dxCode: dxCode)
            }
        }
    }
    
    private static func decode(_ image: CGImage, _ barcodeSide: CGRect.RelativePosition?) async -> DXCode? {
        await DXCode(from: image, barcodeSide)
    }
    
    private func add(dxCode: DXCode?) {
        potentialDXCodeBuffer.add(dxCode)
        guard let mostFrequentDXCode = potentialDXCodeBuffer.buffer.mostFrequentElement(),
              mostFrequentDXCode.percentage >= Constants.Scanner.dxCodeDetectorPrecision else {
            self.dxCode = nil
            return
        }
        withAnimation {
            self.dxCode = mostFrequentDXCode.element
        }
    }
}
