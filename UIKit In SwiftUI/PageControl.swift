//
//  PageControl.swift
//  UIKit In SwiftUI
//
//  Created by Eric Dolecki on 2/26/20.
//  Copyright © 2020 Eric Dolecki. All rights reserved.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        
        return pageControl
    }
    
    func updateUIView(_ pageControl: UIPageControl, context: Context) {
        pageControl.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var pageControl: PageControl
        
        init(_ pageControl: PageControl) {
            self.pageControl = pageControl
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            pageControl.currentPage = sender.currentPage
        }
    }
}
