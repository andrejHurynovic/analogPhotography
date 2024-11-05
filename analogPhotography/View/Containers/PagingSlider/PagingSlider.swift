//
//  PagingSlider.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 25.10.2024.
//

import SwiftUI
import SwiftData

struct PagingSlider<Content: View, TitleContent: View, Items: RandomAccessCollection>: View
where Items: MutableCollection, Items.Element: Identifiable {
    var items: Items
    @Binding var activeID: Items.Element.ID?
    
    @ViewBuilder var content: (Items.Element) -> Content
    @ViewBuilder var titleContent: (Items.Element) -> TitleContent
    
    let titleScrollSpeed: CGFloat = 0.65
    let animationDuration: TimeInterval = 0.35
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(items, id: \.id) { item in
                        VStack(alignment: .center) {
                            titleContent(item)
                                .frame(maxWidth: .infinity)
                                .visualEffect { content, geometryProxy in
                                    content.offset(x: titleContentScrollOffset(geometryProxy))
                                }
                            content(item)
                        }
                        .id(item.id)
                        .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeID)
            .safeAreaPadding([.horizontal])
            
            PagingControl(numberOfPages: items.count, currentPage: activePage) { pageIndex in
                print("pageIndex: \(pageIndex)")
                guard let index = pageIndex as? Items.Index,
                        items.indices.contains(index) else { return }
                withAnimation(.snappy(duration: animationDuration)) {
                    activeID = items[index].id
                }
            }
        }
    }
    
    nonisolated func titleContentScrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.bounds(of: .scrollView)?.minX ?? 0
        return -minX * min(titleScrollSpeed, 1.0)
    }
    
    private var activePage: Int {
        guard let index = items.firstIndex(where: { $0.id == activeID }) as? Int else { return 0 }
        print("activePage: \(index)")
        return index
    }
        
}
