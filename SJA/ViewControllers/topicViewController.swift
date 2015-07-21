//
//  TopicViewController.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/15/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {

    
    @IBOutlet weak var articleTableView: UITableView!
    
    
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    //var currentTopic: Topic?
    
    var currentTopic: String?
    
    var feedParser = FeedHelper(givenURL: "http://www.blackgirldangerous.org/category/race/feed/")

    override func viewDidLoad() {
        super.viewDidLoad()
        println(currentTopic)
        navigationController?.title.text = currentTopic
        
        // Take out range of topic view controllers in between current and main
        if let navigationController = navigationController {
            var navControllers = navigationController.viewControllers
            if navControllers.count > 2 {
                navControllers.removeRange(1..<(navControllers.count - 1))
                navigationController.viewControllers = navControllers
            }
        }
        
        articleTableView.dataSource = self
        articleTableView.delegate = self
        menuContainer.hidden = true
        
        // Parsing done notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList:", name:"refreshArticleNameTableView", object: nil)
    }
    
    func refreshList(notification: NSNotification){
        articleTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        feedParser.request()
        
        self.articleTableView.reloadData()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func menuAction() {
        if menuContainer!.hidden {
            menuContainer!.hidden = false
        } else {
            menuContainer!.hidden = true
        }
    }

    
}

extension TopicViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleNameCell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        //println(feedParser.feedItems)
        
        let item = feedParser.feedItems[indexPath.row] as MWFeedItem
        cell.articleName.text = item.title
        //cell.articleSource.text =
        
        return cell
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedParser.feedItems.count
    }
    
}

extension TopicViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

    }
}
