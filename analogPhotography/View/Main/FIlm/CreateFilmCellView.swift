//
//  CreateFilmCellView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 6.10.24.
//

import SwiftUI

struct CreateFilmCellView: View {
    var dxCode: DXCode
    
    var body: some View {
            NavigationLink(value: Route.film(Film(from: dxCode))) {
                VStack(alignment: .listRowSeparatorLeading) {
                    name
                    HStack {
                        parameters
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                }
            }
    }
    
    var name: some View {
        Text("Create new film from DX code ")
            .font(.title2)
            .fontWeight(.bold)
    }
    
    @ViewBuilder var parameters: some View {
        if let capacity = dxCode.capacity {
            Text("\(capacity) exposures")
        }
        if let speed = dxCode.speed {
            Text("\(speed) ISO")
        }
    }
}

#Preview {
    RoutedNavigationStack {
        CreateFilmCellView(dxCode: DXCode(speed: 200, capacity: 36, exposureTolerance: FilmExposureTolerance(-1,1)))
    }
}
