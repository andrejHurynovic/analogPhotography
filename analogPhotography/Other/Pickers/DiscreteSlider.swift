//
//  DiscreteSlider.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 16.06.24.
//

import SwiftUI

struct DiscreteSlider: View {
    @Bindable var viewModel: DiscreteSliderViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.firstValueText)
            Slider(value: viewModel.sliderIndex, in: viewModel.sliderBounds , step: 1.0)
            Text(viewModel.lastValueText)
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
                
                DiscreteSlider(viewModel: DiscreteSliderViewModel(value: $value,
                                                                  values: Constants.Photo.shutterSpeeds))
            }
        }
    }
    
    return DiscreteSliderContainer()
}
