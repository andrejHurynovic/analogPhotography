//
//  FilmDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 20.07.24.
//

import SwiftUI

struct FilmDetailedView: View {
    @Bindable var film: Film
    
    var body: some View {
        DetailedView(model: film, viewModelType: FilmDetailedViewModel.self) { viewModel, viewModelBinding in
            Form {
                TextFieldForm(title: "Name", text: viewModelBinding.model.name.unwrappedOptional(), viewState: viewModelBinding.viewState)
                Section("Properties") {
                    TextFieldForm(title: "Capacity", text: viewModelBinding.model.capacity.unwrappedOptional(), viewState: viewModelBinding.viewState)
                    TextFieldForm(title: "Speed", text: viewModelBinding.model.speed.unwrappedOptional(), viewState: viewModelBinding.viewState)
                }
                .keyboardType(.numberPad)
                
                Section("Relations") {
                    FilmFormatPicker(filmFormat: viewModelBinding.model.format)
                    FilmProcessPicker(filmProcess: viewModelBinding.model.process)
                }
                Section("Rolls") {
                    AddModelButton {  }
                }
                Section("DX-Code") {
                    DXCodeView(dxCode: film.dxCode)
                }
            }
        }
    }
}

#Preview {
    ModelPreview { film in
        FilmDetailedView(film: film)
    }
}
