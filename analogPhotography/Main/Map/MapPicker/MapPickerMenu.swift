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
    var selectedLocation: Location?
    
    let cornerRadius: CGFloat = 8.0
    
    var inSheet: Bool = false
    var backgroundStyle: Color {
        inSheet ? Color(UIColor.systemGroupedBackground) : Color(UIColor.systemBackground)
    }
    
    var isRedacted: Bool { viewModel.isUpdatingDescriptionText || viewModel.inTransition }
    
    var body: some View {
        HStack {
            placeDescription
            Spacer()
//            searchBar
        }
        .background(backgroundStyle)
        .clipShape(.rect(topLeadingRadius: cornerRadius,
                         bottomLeadingRadius: inSheet ? 0.0 : cornerRadius,
                         bottomTrailingRadius: inSheet ? 0.0 : cornerRadius,
                         topTrailingRadius: cornerRadius))
        .padding(inSheet ? 0.0 : 8.0)
    }
    
    @ViewBuilder var placeDescription: some View {
        Text(viewModel.descriptionText)
            .padding(8)
            .redacted(reason: isRedacted ? .placeholder : [])
            .shimmering(active: isRedacted, bandSize: 0.8, mode: .mask)
        
            .animation(.default, value: viewModel.isUpdatingDescriptionText)
    }
    
//    var searchBar: some View {
//        HStack(spacing: 4) {
//            Text(Image(systemName: "magnifyingglass"))
//            TextField("",
//                      text: $viewModel.searchText,
//                      prompt: Text(" Поиск на карте"))
//            .textFieldStyle(.plain)
//            .foregroundStyle(Color(UIColor.systemBackground))
//        }
//        .foregroundStyle(.gray)
//        .padding(8)
//        .background(.bar, in: RoundedRectangle(cornerRadius: 8))
//        .padding()
//        
//    }
}

#Preview {    
    return MapPickerPreview()
}
