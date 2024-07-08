//
//  OptionalDatePicker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 8.07.24.
//

import SwiftUI

struct OptionalDatePicker: View {
    @Bindable var viewModel: OptionalDatePickerViewModel
    
    var body: some View {
        HStack {
            Text("Date")
            Spacer()
            if viewModel.isEnabled {
                DatePicker("", selection: viewModel.innerDate)
                ClearFormButton { viewModel.disablePicker() }
            } else {
                TapToAddButton { viewModel.enablePicker() }
            }
        }
        
        .animation(.default, value: viewModel.isEnabled)
        
    }
}

#Preview {
    struct OptionalDatePickerPreview: View {
        @State var date: Date? = nil
        
        var body: some View {
            List {
                OptionalDatePicker(viewModel: OptionalDatePickerViewModel(date: $date))
                Section("Developer") {
                    TextFormView("Date", "\(String(describing: date))")
                    Button("Change date") {
                        date = .distantFuture
                    }
                    Button("Remove date", role: .destructive) {
                        date = nil
                    }
                }
            }
        }
    }
    
    return OptionalDatePickerPreview()
}
