//
//  DiscreteSlider.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 16.06.24.
//

import SwiftUI

struct DiscreteSlider<ValueType>: View where ValueType: Equatable {
    
    @Binding private var value: ValueType
    private var values: [ValueType]
    
    @State private var needReset: Bool = false
    @State private var sliderIndex: Double = 0.0
    
    init(value: Binding<ValueType>, values: [ValueType]) {
        self._value = value
        self.values = values
        
        self._sliderIndex = State(initialValue: (self.findIndex() ?? 0.0))
    }
    
    
    var body: some View {
        HStack {
            resetButton
            if let first = values.first as? String {
                Text(first)
            }
            slider
            if let last = values.last as? String {
                Text(last)
            }
        }
    }
    
    var slider: some View {
        Slider(value: $sliderIndex, in: 0.0...(Double(values.count) - 1.0) , step: 1.0)
            .disabled(needReset)
            .animation(.default, value: sliderIndex)
            .animation(.default, value: needReset)
        
            .onChange(of: value) { _, newValue in
                guard let newIndex = findIndex() else {
                    self.needReset = true
                    return
                }
                sliderIndex = newIndex
            }
            .onChange(of: sliderIndex) { _, newSliderIndex in
                value = values[Int(newSliderIndex)]
            }
    }
    
    @ViewBuilder var resetButton: some View {
        if needReset {
            Button("", systemImage: "arrow.uturn.backward.circle") {
                guard let firstValue = values.first else { return }
                value = firstValue
            }
        }
    }
    
    private func findIndex() -> Double? {
        if let index = values.firstIndex(of: value) {
            needReset = false
            return Double(index)
        } else {
            needReset = true
            return nil
        }
    }
}



#Preview {
    struct DiscreteSliderContainer: View {
        @State private var value: String = ""
        
        var body: some View {
            List {
                TextFieldFormView(title: "Скорость затвора",
                                  text: $value,
                                  editState: .constant(true))
                HStack {
                    DiscreteSlider(value: $value, values: Constants.Other.shutterSpeeds)
                }
            }
        }
    }
    
    return DiscreteSliderContainer()
}
