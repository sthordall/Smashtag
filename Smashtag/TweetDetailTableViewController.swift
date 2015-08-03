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
    
    var tweet: Tweet? = nil
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source
    var sections : [String] {
        get {
            var retSections = [String]()
            if(tweet?.hashtags.count > 0) {retSections.append("Hashtags")}
            if(tweet?.media.count > 0) {retSections.append("Images")}
            if(tweet?.urls.count > 0) {retSections.append("Urls")}
            if(tweet?.userMentions.count > 0) {retSections.append("Users")}
            return retSections
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < sections.count {
            let sectionToCount = sections[section]
            if tweet != nil {
                switch sectionToCount {
                case "Hashtags":
                    return tweet!.hashtags.count
                case "Images":
                    return tweet!.media.count
                case "Urls":
                    return tweet!.urls.count
                case "Users":
                    return tweet!.userMentions.count
                default:
                    break
                }
            }
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IndexedKeywordCell") as! UITableViewCell
        if indexPath.section < sections.count {
            let section =  sections[indexPath.section]
            switch section {
            case "Hashtags":
                cell.textLabel?.text = tweet?.hashtags[indexPath.row].keyword
            case "Images":
                cell.textLabel?.text = tweet?.media[indexPath.row].url.description
            case "Urls":
                cell.textLabel?.text = tweet?.urls[indexPath.row].keyword
            case "Users":
                cell.textLabel?.text = tweet?.userMentions[indexPath.row].keyword
            default:
                break
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
