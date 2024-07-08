//
//  OptionalDatePickerViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 9.07.24.
//

import SwiftUI

@Observable
final class OptionalDatePickerViewModel {
    private var date: Binding<Date?>
    var innerDate: Binding<Date>
    
    var isEnabled: Bool {
        date.wrappedValue != nil
    }
    
    init(date: Binding<Date?>) {
        self._date = date
        self.innerDate = Binding(
            get: {
                return date.wrappedValue ?? .now
            },
            set: {
                date.wrappedValue = $0
            })
    }
    
    func enablePicker() {
            date.wrappedValue = .now
    }
    func disablePicker() {
            date.wrappedValue = nil
    }
    
}
