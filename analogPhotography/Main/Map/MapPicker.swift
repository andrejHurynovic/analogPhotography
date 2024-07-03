//
//  MapPicker.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 17.06.24.
//

import SwiftUI
import MapKit

struct MapPicker: View {
    @Binding var selectedLocation: Location?
    
    @State var otherItems: [LocationItem]
    @State var favoriteItems: [LocationItem]
    
    @State private var viewModel = MapPickerViewModel()
    
    var body: some View {
        map
            .overlay { centralMarker }
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundStyle(.tint)
        //            .safeAreaInset(edge: .bottom) { bottomMenu }
        //MARK: onChange
        .onMapCameraChange(frequency: .continuous, { context in
            viewModel.mapCameraUpdated()
        })
        .onMapCameraChange(frequency: .onEnd, { context in
            viewModel.mapCameraEnded(position: context.region.center,
                                     distance: context.camera.distance)
        })
        .onChange(of: viewModel.selectedItem) { viewModel.selectedItemUpdated(item: $1) }
        .onChange(of: viewModel.finalLocation, { selectedLocation = .init(from: $1) })
        
    }
    
    @ViewBuilder var map: some View {
        Map(position: $viewModel.position, selection: $viewModel.selectedItem) {
            ForEach(otherItems) { item in
                Marker(item.description, systemImage: "camera", coordinate: item.clLocation)
                    .tag(item)
            }
            ForEach(favoriteItems) { item in
                Marker(item.description, systemImage: "star", coordinate: item.clLocation)
                    .tag(item)
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
    
    //    var bottomMenu: some View {
    //        VStack {
    //            searchBar
    //        }
    //        .background(Color(UIColor.systemGroupedBackground))
    //        .clipShape(.rect(topLeadingRadius: 8.0, topTrailingRadius: 8.0))
    //    }
    
    //    var searchBar: some View {
    //        HStack(spacing: 4) {
    //            Text(Image(systemName: "magnifyingglass"))
    //            TextField("",
    //                      text: $searchText,
    //                      prompt: Text(" Поиск на карте"))
    //                .textFieldStyle(.plain)
    //                .foregroundStyle(Color(UIColor.systemBackground))
    //        }
    //        .foregroundStyle(.gray)
    //        .padding(8)
    //        .background(.bar, in: RoundedRectangle(cornerRadius: 8))
    //        .padding()
    //
    //    }
}

//MARK: Preview

#Preview {
    struct MapPickerContainer: View {
        @State var selectedLocation: Location?
        
        var body: some View {
            NavigationStack {
                List {
                    MapPicker(selectedLocation: $selectedLocation,
                              otherItems: [LocationItem(description: "1",
                                                        location: .init(latitude: 53.921563, longitude: 27.641113)),
                                           LocationItem(description: "2",
                                                        location: .init(latitude: 53.912463, longitude: 27.630100)),
                                           LocationItem(description: "3",
                                                        location: .init(latitude: 53.916195, longitude: 27.636173))],
                              favoriteItems: [])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    TextFormView("selectedLocation", String(selectedLocation.debugDescription))
                }
            }
        }
    }
    
    return MapPickerContainer()
}
