//
//  FilmRollDetailedView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 25.07.24.
//

import SwiftUI

struct FilmRollDetailedView: View {
    @Bindable var filmRoll: FilmRoll
    
    var body: some View {
        DetailedView(model: filmRoll, viewModelType: FilmRollDetailedViewModel.self) { viewModel, viewModelBinding in
            Form {
                TextFieldForm(title: "Name", text: viewModelBinding.model.name.unwrappedOptional(), viewState: viewModelBinding.viewState)
                Section("Properties") {
                    Toggle("Expired", isOn: viewModelBinding.model.expired)
                    Toggle("Finished", isOn: viewModelBinding.model.finished)
                    LabeledContent("Creation date", value: viewModel.model.creationDate.formatted(date: .numeric, time: .omitted))
                }
                Section("Realtions") {
                    LabeledContent("Camera") {
                        <#code#>
                    }
                    LabeledContent("Roll") {
                        <#code#>
                    }
                }
                Section("Photos") {
                    
                }
            }
        }
    }
}

/*
 var name: String?
     var note: String = ""
     
     var expired: Bool
     var creationDate: Date
     var finished: Bool = false
     
     @Relationship(inverse: \Film.rolls) var film: Film?
     @Relationship(deleteRule: .cascade, inverse: \Photo.filmRoll) var photos: [Photo]
     
     @Relationship(inverse: \Camera.filmRolls) var camera: Camera?
 */
#Preview {
    ModelPreview { filmRoll in
        FilmRollDetailedView(filmRoll: filmRoll)
    }
}
