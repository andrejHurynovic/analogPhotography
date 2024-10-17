//
//  HomeViewModel.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 09.10.2024.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    var isMenuVisible: Bool { searchText.isEmpty }
}
