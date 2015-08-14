//
//  HistoryTableViewController.swift
//  Smashtag
//
//  Created by Stephan Thordal Larsen on 13/08/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var history: [String] {
        get{return TweetHistory.history}
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: Data Source
    private struct Storyboard {
        static let HistoryCellReuseIdentifier = "HistoryTweetSearch"
        static let HistorySearchSegueIdentifier = "HistorySearchSegue"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.HistoryCellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = history[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if var dvc = segue.destinationViewController as? UIViewController {
            switch segue.identifier! {
            case Storyboard.HistorySearchSegueIdentifier:
                let tabVC = dvc as? UITabBarController
                let tweetTVC = tabVC?.childViewControllers[0] as? TweetTableViewController
                let senderCell = sender as? UITableViewCell
                tweetTVC?.searchText = senderCell?.textLabel?.text
            default:
                print("Destination View Controller has unknown ID")
            }
        }
    }
}
