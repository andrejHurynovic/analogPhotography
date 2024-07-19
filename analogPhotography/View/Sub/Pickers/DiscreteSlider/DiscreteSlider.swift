//
//  DiscreteSlider.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 16.06.24.
//

import SwiftUI

struct DiscreteSlider: View {
    @Binding var value: String
    @StateObject var viewModel: DiscreteSliderViewModel
    
    init(value: Binding<String>, values: [String]) {
        self._value = value
        self._viewModel = StateObject(wrappedValue: DiscreteSliderViewModel(initialValue: value.wrappedValue, values: values))
    }
    
    var body: some View {
        HStack {
            Text(viewModel.firstValueText)
            Slider(value: $viewModel.sliderIndex, in: viewModel.sliderBounds , step: 1.0)
                .disabled(!viewModel.isEnabled)
                .opacity(viewModel.isEnabled ? 1.0 : 0.5)
                .tint(viewModel.isEmpty ? Color(uiColor: .systemGray5) : .accentColor)
            Text(viewModel.lastValueText)
        }
        .animation(.default, value: value)
        
        .onChange(of: value) { viewModel.handleValueChange($1) }
        .onChange(of: viewModel.sliderIndex) {
            viewModel.handleSliderIndexChange()
            value = viewModel.getValue()
        }
    }
}

#Preview {
    struct DiscreteSliderPreview: View {
        @State private var value: String = "1/500"
        
        var body: some View {
            ShutterSpeedPicker(value: $value)
        }
    }
    
    return DiscreteSliderPreview()
}
