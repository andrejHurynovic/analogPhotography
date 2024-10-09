//
//  HomeView.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 6.10.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject var viewModel = HomeViewViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                HStack(spacing: 16) {
                    TextField("", text: $viewModel.searchText, prompt: Text("Search"))
                        .frame(height: 16)
                        .padding()
                        .background(.thinMaterial, in: Capsule())
                    menu
                }
                camerasGrid
            }
            .padding()
        }
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    @ViewBuilder var menu: some View {
        if viewModel.isMenuVisible {
            HomeViewMenu()
        }
    }
    
    @ViewBuilder var camerasGrid: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 250, maximum: .infinity))],
                      alignment: .center,
                      content: {cameras})
        } header: {
            HStack {
                Text("Cameras")
                    .font(.title)
                    .bold()
                Spacer()
            }
        }
        
        
    }
    @ViewBuilder var cameras: some View {
        let searchText = viewModel.searchText
        QueryView(descriptor: FetchDescriptor<Camera>(predicate: #Predicate {
            searchText.isEmpty || $0.name.localizedStandardContains(searchText)
        })) { camera in
            CameraRowView(camera: camera)
                .floatingBackground()
        }
    }
}

struct QueryView<Element : PersistentModel, Content: View>: View {
    @Query var elements: [Element]
    let content: (Element) -> Content
    
    init(descriptor: FetchDescriptor<Element>,
         content: @escaping (Element) -> Content) {
        
        self._elements = Query(descriptor, animation: .default)
        self.content = content
    }
    
    var body: some View {
        ForEach(elements, id: \.id) { element in
            content(element)
        }
    }
}

#Preview {
    NavigationStackPreview {
        HomeView()
    }
}
