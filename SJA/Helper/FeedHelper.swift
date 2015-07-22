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
    var topicURL: String?
    
    init(givenURL: String) {
        super.init()
        
        topicURL = givenURL
        request()
    }
    
    func request() {
        let url = NSURL(string: topicURL!)
        let feedParser = MWFeedParser(feedURL: url)
        feedParser.delegate = self
        feedParser.parse()
    }
    
    //MARK: - Feed Parser Delegate
    
    func feedParserDidStart(parser: MWFeedParser!) {
        feedItems = [MWFeedItem]()
    }
    
    func feedParserDidFinish(parser: MWFeedParser!) {
//        NSNotificationCenter.defaultCenter().postNotificationName("refreshArticleNameTableView", object: nil)
    }

    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        println("Item loaded")
        feedItems.append(item)
    }
    
}
