//
//  FeedHelper.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/20/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit

class FeedHelper: MWFeedParser, MWFeedParserDelegate {
    
    var feedItems = [MWFeedItem]()
    var topicViewController = TopicViewController()
    
    func request() {
        let url = NSURL(string: "http://www.blackgirldangerous.org/category/race/feed/")
        let feedParser = MWFeedParser(feedURL: url)
        feedParser.delegate = self
        feedParser.parse()
    }
    
    //MARK: - Feed Parser Delegate
    func feedParserDidStart(parser: MWFeedParser!) {
        feedItems = [MWFeedItem]()
    }
    
    func feedParserDidFinish(parser: MWFeedParser!) {
        NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)
        //topicViewController.articleTableView.reloadData()
    }
    
//    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
//        topicViewController.tableView.articleName = info.title
//    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        feedItems.append(item)
    }
    
}
