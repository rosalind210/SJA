//
//  FeedCollector.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/21/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import Foundation
import UIKit


class FeedCollector {
    
    var feedArray: [String] = []
    var feedItems = [MWFeedItem]()
    
    init(listOfURLs: [String]) {
        feedArray = listOfURLs
    }
    
    func refreshTableView(tableView: UITableView){
        tableView.reloadData()
    }
    
    func createFeedHelpers() {
        for i in 0...feedArray.count-1 {
            var url = feedArray[i]
            
            var feed = FeedHelper(givenURL: url)
            addFeedItems(feed)
            //println("Feed finished \(i)")
        }
        
    }
    
    func addFeedItems(feed: FeedHelper) {
        for i in feed.feedItems {
            feedItems.append(i)
        }
    }
    
}