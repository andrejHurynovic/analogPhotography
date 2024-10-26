//
//  PagingControl.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 26.10.2024.
//

import SwiftUI

extension PagingSlider {
    struct PagingControl: UIViewRepresentable {
        var numberOfPages: Int
        var currentPage: Int
        var onPageChange: (Int) -> ()
        
        func makeUIView(context: Context) -> UIPageControl {
            let view = UIPageControl()
            
            view.numberOfPages = numberOfPages
            view.currentPage = currentPage
            
            view.backgroundStyle = .prominent
            view.pageIndicatorTintColor = UIColor.placeholderText
            view.currentPageIndicatorTintColor = UIColor(Color.primary)
            
            view.addTarget(context.coordinator,
                           action: #selector(PagingControlCoordinator.onPageUpdate(control:)),
                           for: .valueChanged)
            return view
        }
        func updateUIView(_ uiView: UIPageControl, context: Context) {
            uiView.numberOfPages = numberOfPages
            uiView.currentPage = currentPage
        }
        
        func makeCoordinator() -> PagingControlCoordinator {
            PagingControlCoordinator(onPageChange: onPageChange)
        }
        
        class PagingControlCoordinator: NSObject {
            var onPageChange: (Int) -> ()
            init(onPageChange: @escaping (Int) -> Void) {
                self.onPageChange = onPageChange
            }
            
            @MainActor @objc
            func onPageUpdate(control: UIPageControl) {
                onPageChange(control.currentPage)
            }
        }
    }
}
