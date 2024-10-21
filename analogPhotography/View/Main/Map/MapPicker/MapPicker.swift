//
//  MapPicker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.06.24.
//

import SwiftUI
import MapKit

struct MapPicker: View {
    @State var viewModel: MapPickerViewModel
    
    var otherItems: [LocationItem]
    var favoriteItems: [LocationItem]
    
    var body: some View {
        map
            .overlay { centralMarker }
            .foregroundStyle(.tint)
            .safeAreaInset(edge: .bottom) { MapPickerMenu(viewModel: viewModel) }
            .aspectRatio(1.0, contentMode: .fit)
        //MARK: onChange
        .onMapCameraChange(frequency: .continuous, {
            viewModel.mapCameraUpdated()
        })
        .onMapCameraChange(frequency: .onEnd, { context in
            viewModel.mapCameraEnded(context: context)
        })
        .onChange(of: viewModel.selectedItem) { viewModel.selectedItemUpdated(item: $1) }
        
    }
    
    @ViewBuilder var map: some View {
        Map(position: $viewModel.position, selection: $viewModel.selectedItem) {
            ForEach(otherItems) { item in
                Marker(item.description ?? "", systemImage: "camera", coordinate: item.clLocation)
                    .tag(item)
            }
            ForEach(favoriteItems) { item in
                Marker(item.description ?? "", systemImage: "star", coordinate: item.clLocation)
                    .tag(item)
            }
            ForEach(viewModel.searchItems) { item in
                Marker(item: item)
                    .tag(LocationItem(from: item))
            }
        }
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
    }
    
    @ViewBuilder var centralMarker: some View {
        MapMarker(showPicker: viewModel.showPicker,
                  inTransition: viewModel.inTransition)
    }
    
}

//MARK: Preview

#Preview {
    @Previewable @State var selectedLocation: Location?
    @Previewable @State var otherItems = [LocationItem(description: "1",
                                                       location: .init(latitude: 53.921563, longitude: 27.641113)),
                                          LocationItem(description: "2",
                                                       location: .init(latitude: 53.912463, longitude: 27.630100)),
                                          LocationItem(description: "3",
                                                       location: .init(latitude: 53.916195, longitude: 27.636173))]
    
    RoutedNavigationStack {
        List {
            MapPicker(viewModel: MapPickerViewModel(selectedLocation: $selectedLocation),
                      otherItems: otherItems,
                      favoriteItems: [])
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            TextForm("selectedLocation", selectedLocation?.description)
            Button("Add test item") {
                guard let location = selectedLocation else { return }
                otherItems.append(LocationItem(location: location))
            }
        }
    }
}
