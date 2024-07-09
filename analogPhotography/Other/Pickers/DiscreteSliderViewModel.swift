//
//  DiscreteSliderViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 9.07.24.
//

import SwiftUI

@Observable
class DiscreteSliderViewModel {
    var sliderBounds: ClosedRange<Double>
    var sliderIndex: Binding<Double>
        
    var firstValueText: String
    var lastValueText: String
    
    init(value: Binding<String>, values: [String]) {
        self.sliderBounds = 0.0...(Double(values.count) - 1.0)
        self.sliderIndex = Binding(
            get: {
                guard let index = values.firstIndex(of: value.wrappedValue) else {
                    return 0.0
                }
                return Double(index)
            },
            set: {
                Haptic.impact(.light)
                value.wrappedValue = values[Int($0)]
            })
        
        self.firstValueText = values.first ?? ""
        self.lastValueText = values.last ?? ""
    }
    
}
