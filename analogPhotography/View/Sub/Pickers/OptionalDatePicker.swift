//
//  OptionalDatePicker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 8.07.24.
//

import SwiftUI

struct OptionalDatePicker: View {
    @Binding var date: Date?
    var isEnabled: Bool { date != nil }
    
    var body: some View {
        HStack {
            Text("Date")
            Spacer()
            if isEnabled {
                datePicker
                ClearFormButton { disablePicker() }
            } else {
                TapToAddButton { enablePicker() }
            }
        }
        .animation(.default, value: isEnabled)
    }
    
    var datePicker: some View {
        DatePicker("", selection: Binding(
            get: { return date ?? .now },
            set: { date = $0 }))
    }
    
    //MARK: - Functions
    private func enablePicker() { date = .now }
    private func disablePicker() { date = nil }
}

#Preview {
    @Previewable @State var date: Date? = nil
    
    Form {
        OptionalDatePicker(date: $date)
        Section("Debug") {
            TextForm("Date", "\(String(describing: date))")
            Button("Change date to distantFuture") { date = .distantFuture }
            Button("Remove date", role: .destructive) { date = nil }
        }
    }
}
