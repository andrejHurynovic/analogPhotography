//
//  ShutterSpeedPicker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 10.07.24.
//

import SwiftUI

struct ShutterSpeedPicker: View {
    @Binding var value: String
    
    var body: some View {
        TextFieldForm(title: "Shutter speed",
                          placeholder: "1/100",
                          text: $value)
        DiscreteSlider(value: $value, values: Constants.Photo.shutterSpeeds)
    }
    
}

#Preview {
    @Previewable @State var value: String = "1/100"
    Form {
        ShutterSpeedPicker(value: $value)
    }
}
