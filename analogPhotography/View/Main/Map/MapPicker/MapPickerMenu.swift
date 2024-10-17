//
//  MapPickerMenu.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 3.07.24.
//

import SwiftUI
import Shimmer

struct MapPickerMenu: View {
    @State var viewModel: MapPickerViewModel
    var inSheet: Bool = false
    
    var backgroundStyle: Color { inSheet ? Color(UIColor.systemBackground) : Color(UIColor.systemGroupedBackground)}
    let cornerRadius: CGFloat = 8.0
    
    @FocusState var searchFocus: Bool
    var isRedacted: Bool { viewModel.isUpdatingDescriptionText || viewModel.inTransition }
    
    var body: some View {
        searchBar
            .background(backgroundStyle
                .clipShape(.rect(topLeadingRadius: cornerRadius,
                                 bottomLeadingRadius: inSheet ? 0.0 : cornerRadius,
                                 bottomTrailingRadius: inSheet ? 0.0 : cornerRadius,
                                 topTrailingRadius: cornerRadius)
                )
            )
            .padding(inSheet ? 0.0 : 8.0)
    }
    
    @ViewBuilder var searchBar: some View {
        HStack(spacing: 4) {
            searchBarImage
                .foregroundStyle(.gray)
            searchBarTextField
            .animation(.default, value: viewModel.isUpdatingDescriptionText)
            .animation(.default, value: viewModel.searchBarState)
        }
        .padding(8)
        .background(.bar, in: RoundedRectangle(cornerRadius: 8))
        .padding()
    }
    
    @ViewBuilder var searchBarImage: some View {
        if isRedacted {
            ProgressView()
        } else {
            switch viewModel.searchBarState {
                case .search:
                    Text(Image(systemName: "magnifyingglass"))
                case .description:
                    Text(Image(systemName: "mappin.circle.fill"))
            }
            
        }
    }
    
    @ViewBuilder var searchBarTextField: some View {
        TextField("",
                  text: viewModel.searchBarState == .search ? $viewModel.searchText : $viewModel.descriptionText,
                  prompt: Text(" Поиск на карте"))
        .foregroundStyle(viewModel.searchBarState == .search ? .primary : Color.gray)
        .focused($searchFocus)
        .redacted(reason: isRedacted ? .placeholder : [])
        .shimmering(active: isRedacted, bandSize: 0.8)
        
        .onSubmit { viewModel.search() }
        
        .onChange(of: searchFocus) {
            viewModel.searchFocusedUpdated($1)
        }
    }
}
