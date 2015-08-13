//
//  DetailImageViewController.swift
//  Smashtag
//
//  Created by Stephan Thordal Larsen on 07/08/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController, UIScrollViewDelegate {

    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            syncScrollView()
        }
    }
    
    private var imageView = UIImageView()
    
    private func syncScrollView() {
        if scrollViewScrolledOrZoomed && scrollView != nil && image != nil {
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            
            scrollView!.zoomScale = min(
                scrollView!.bounds.size.height / image!.size.height,
                scrollView!.bounds.size.width / image!.size.width)
            
            scrollView!.minimumZoomScale = scrollView!.zoomScale
            
            scrollView!.contentOffset = CGPoint(
                x: (imageView.frame.size.width - scrollView!.frame.size.width) / 2,
                y: (imageView.frame.size.height - scrollView!.frame.size.height) / 2)
            
            scrollViewScrolledOrZoomed = false

        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 10
        }
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Image"
        scrollView.addSubview(imageView)
        syncScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        syncScrollView()
    }

    
    // MARK: ScrollView Delegation
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var scrollViewScrolledOrZoomed = false
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        scrollViewScrolledOrZoomed = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollViewScrolledOrZoomed = true
    }
}
