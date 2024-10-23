//
//  PhotoDetailedViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 23.10.2024.
//

import SwiftUI
import SwiftData

final class PhotoDetailedViewModel: ModelViewModel<Photo>, ModelViewModelProtocol {
    var name: String { model.order.formatted() }
}
