//
//  DetailImageViewController.swift
//  Smashtag
//
//  Created by Stephan Thordal Larsen on 07/08/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController {

    var image: UIImage? {
        didSet {
            imageView?.image = image
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func pinchGestureRecognizer(sender: UIPinchGestureRecognizer) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        navigationItem.title = "Image"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
