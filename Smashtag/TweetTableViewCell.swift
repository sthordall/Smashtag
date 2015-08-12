//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
 
    @IBInspectable var hashtagColor = UIColor.orangeColor()
    @IBInspectable var userMentionColor = UIColor.purpleColor()
    @IBInspectable var urlColor = UIColor.blueColor()
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {
            var tweetAttributedText = NSMutableAttributedString(string: tweet.text)
            
            for hashtag in tweet.hashtags {
                tweetAttributedText.addAttribute(NSForegroundColorAttributeName,
                    value: hashtagColor, range: hashtag.nsrange)
            }
            
            for userMention in tweet.userMentions {
                tweetAttributedText.addAttribute(NSForegroundColorAttributeName,
                    value: userMentionColor, range: userMention.nsrange)
            }
            
            for url in tweet.urls {
                tweetAttributedText.addAttribute(NSForegroundColorAttributeName,
                    value: urlColor, range: url.nsrange)
            }

            tweetTextLabel?.attributedText = tweetAttributedText
            
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                let queue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
                dispatch_async(queue) {
                    if let imageData = NSData(contentsOfURL: profileImageURL) { // TODO: Check if this multithreading works
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tweetProfileImageView?.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }

    }
}
