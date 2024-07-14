//
//  DiscreteSliderViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 9.07.24.
//

import SwiftUI

extension DiscreteSlider {
    final class DiscreteSliderViewModel: ObservableObject {
        let values: [String]
        let sliderBounds: ClosedRange<Double>
        
        @Published var sliderIndex: Double = 0.0
        @Published var isEnabled: Bool = true
        @Published var isEmpty: Bool = false
        
        let firstValueText: String
        let lastValueText: String
        
        //MARK: - Initialization
        
        init(initialValue: String, values: [String]) {
            self.values = values
            self.sliderBounds = 0.0...(Double(values.count) - 1.0)
            
            self.firstValueText = values.first ?? ""
            self.lastValueText = values.last ?? ""
            
            self.handleValueChange(initialValue)
        }
        
        //MARK: - Methods
        
        func handleValueChange(_ newValue: String) {
            withAnimation {
                guard !newValue.isEmpty else {
                    isEnabled = true
                    isEmpty = true
                    return
                }
                isEmpty = false
                guard let index = findIndex(of: newValue) else {
                    isEnabled = false
                    return
                }
                sliderIndex = index
                isEnabled = true
            }
        }
        func handleSliderIndexChange() {
            Haptic.impact(.light)
        }
        
        func getValue() -> String {
            return values[Int(sliderIndex)]
        }
        
        private func findIndex(of value: String) -> Double? {
            guard let index = values.firstIndex(of: value) else { return nil }
            return Double(index)
        }
        
    }
    
}
