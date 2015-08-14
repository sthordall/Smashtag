//
//  TweetHistoryModel.swift
//  Smashtag
//
//  Created by Stephan Thordal Larsen on 14/08/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TweetHistory {
    private static let userDefaultIdentifier = "SmashTag.TweetHistory"
    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static var history: [String] {
        get {return userDefaults.objectForKey(userDefaultIdentifier) as? [String] ?? []}
        set {userDefaults.setObject(newValue, forKey: userDefaultIdentifier)}
    }
    
    static func addSearch(tweetSearch: String) {
        var currentHistory = history
        if let identicalSearchIndex = find(currentHistory, tweetSearch) {
            currentHistory.removeAtIndex(identicalSearchIndex)
        }
        currentHistory.insert(tweetSearch, atIndex: 0)
        history = currentHistory
    }
}
