//
//  ImageTableViewCell.swift
//  
//
//  Created by Stephan Thordal Larsen on 05/08/15.
//
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    var mediaItem : MediaItem? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var mediaItemImageView: UIImageView!
    
    func updateUI() {
        if mediaItem != nil {
            let queue: dispatch_queue_t = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
            dispatch_async(queue) {
                let imageData = NSData(contentsOfURL: self.mediaItem!.url)
                dispatch_async(dispatch_get_main_queue()) {
                    if imageData != nil {
                        self.mediaItemImageView.image = UIImage(data: imageData!)
                    }
                }
            }
        }
    }
}
