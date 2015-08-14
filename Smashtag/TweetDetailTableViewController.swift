//
//  TweetDetailTableViewController.swift
//  
//
//  Created by Stephan Thordal Larsen on 02/08/15.
//
//

import UIKit

class TweetDetailTableViewController: UITableViewController {

    // MARK: - Public API
    
    var tweet: Tweet? {
        didSet {
            title = tweet?.user.screenName
            if let mediaItems = tweet?.media {
                if mediaItems.count > 0 {
                    tweetSections.append(TweetSection(title: SectionTitle.Images,
                        data: mediaItems.map {CellItem.Image($0.url, $0.aspectRatio)}))
                }
            }
            if let urls = tweet?.urls {
                if urls.count > 0 {
                    tweetSections.append(TweetSection(title: SectionTitle.Urls,
                        data: urls.map {CellItem.IndexedKeyword($0.keyword)}))
                }
            }
            if let hashtags = tweet?.hashtags {
                if hashtags.count > 0 {
                    tweetSections.append(TweetSection(title: SectionTitle.Hashtags,
                        data: hashtags.map {CellItem.IndexedKeyword($0.keyword)}))
                }
            }
            if let userMentions = tweet?.userMentions {
                if userMentions.count > 0 {
                    tweetSections.append(TweetSection(title: SectionTitle.Users,
                        data: userMentions.map {CellItem.IndexedKeyword($0.keyword)}))
                }
            }
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.title = tweet?.user.screenName
    }

    // MARK: - Table view data source
    
    private struct SectionTitle {
        static let Hashtags = "Hashtags"
        static let Images = "Images"
        static let Urls = "Urls"
        static let Users = "Users"
    }
    
    private var tweetSections = [TweetSection]()
    
    private struct TweetSection {
        var title: String
        var data: [CellItem]
    }
    
    private enum CellItem {
        case IndexedKeyword(String)
        case Image(NSURL, Double)
    }
    
    private struct Storyboard {
        static let IndexedKeywordReuseIdentifier = "IndexedKeywordCell"
        static let ImageReuseIdentifier = "Image"
        static let DetailImageSegueIdentifier = "ShowDetailImage"
        static let IndexedKeywordSearchSegueIdentifier = "IndexedKeywordSearch"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweetSections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tweetSections[section].data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCellData = tweetSections[indexPath.section].data[indexPath.row]
        
        switch tableCellData {
        case .IndexedKeyword(let keyword):
            let tableCell = tableView.dequeueReusableCellWithIdentifier(Storyboard.IndexedKeywordReuseIdentifier) as! UITableViewCell
            tableCell.textLabel?.text = keyword
            return tableCell
        case .Image(let url, let aspect):
            let tableCell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ImageReuseIdentifier) as! ImageTableViewCell
            tableCell.imageUrl = url;
            return tableCell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tweetSections[section].title
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tableCellData = tweetSections[indexPath.section].data[indexPath.row]
        
        switch tableCellData {
        case .Image(_, let aspect):
            return tableView.bounds.size.width / CGFloat(aspect)
        default:
            return UITableViewAutomaticDimension
        }
    }

    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        // Intercepting to open browser instead, when click cell is an URL
        if identifier == Storyboard.IndexedKeywordSearchSegueIdentifier {
            if let tableCell = sender as? UITableViewCell {
                if let url = tableCell.textLabel?.text {
                    if let nsUrl = NSURL(string: url) {
                        if UIApplication.sharedApplication().canOpenURL(nsUrl) {
                            UIApplication.sharedApplication().openURL(nsUrl)
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if var dvc = segue.destinationViewController as? UIViewController {
            switch segue.identifier! {
            case Storyboard.IndexedKeywordSearchSegueIdentifier:
                let tabVC = dvc as? UITabBarController
                let tweetTVC = tabVC?.childViewControllers[0] as? TweetTableViewController
                let senderCell = sender as? UITableViewCell
                tweetTVC?.searchText = senderCell?.textLabel?.text
            case Storyboard.DetailImageSegueIdentifier:
                let detailImageVC = dvc as? DetailImageViewController
                let senderCell = sender as? ImageTableViewCell
                detailImageVC?.image = senderCell?.mediaItemImageView?.image
            default:
                print("Destination View Controller has unknown ID")
            }
        }

    }

}
