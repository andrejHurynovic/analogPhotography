//
//  FilmRollDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 25.07.24.
//

import SwiftUI

struct FilmRollDetailedView: View {
    @Bindable var filmRoll: FilmRoll
    var selectedFilmRoll: Binding<FilmRoll?>?
    
    var body: some View {
        DetailedView(model: filmRoll,
                     selectedModel: selectedFilmRoll,
                     viewModelType: FilmRollDetailedViewModel.self) { viewModel, viewModelBinding in
            Form {
                TextFieldForm(title: "Name", text: viewModelBinding.model.name.unwrappedOptional(), viewState: viewModelBinding.viewState)
                Section("Properties") {
                    Toggle("Expired", isOn: viewModelBinding.model.expired)
                    Toggle("Finished", isOn: viewModelBinding.model.finished)
                    LabeledContent("Creation date", value: viewModel.model.creationDate.formatted(date: .numeric, time: .omitted))
                }
                Section("Realtions") {
                    LabeledContent("Camera") {
                        SelectButton(systemImage: "camera.circle") { }
                    }
                    LabeledContent("Film") {
                        SelectButton(systemImage: "film.circle") { }
                    }
                }
                Section("Photos") {
                    AddModelButton {  }
                }
            }
        }
    }
}

#Preview {
    ModelPreview { filmRoll in
        FilmRollDetailedView(filmRoll: filmRoll)
    }
}
